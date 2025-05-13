#!/usr/bin/env python3
import gi
gi.require_version('Gtk', '3.0')
from gi.repository import Gtk, Gdk, GLib
from yt_dlp import YoutubeDL
import os
import subprocess
import threading

class YouTubeDownloader(Gtk.Window):
    def __init__(self):
        super().__init__(title="Spotifixed")
        self.set_border_width(10)
        self.set_default_size(845, 220)

        # Layout: Vertical Box
        # Layout: Vertical Box
        vbox = Gtk.Box(orientation=Gtk.Orientation.VERTICAL, spacing=5)
        self.add(vbox)

        # Create a Grid to organize labels, entries, and buttons
        grid = Gtk.Grid()
        grid.set_column_homogeneous(False)
        grid.set_row_spacing(8)
        grid.set_column_spacing(10)
        vbox.pack_start(grid, False, False, 0)

        # YouTube URL Entry
        url_label = Gtk.Label(label="YouTube URL:", xalign=0)
        grid.attach(url_label, 0, 0, 1, 1)

        self.url_entry = Gtk.Entry(hexpand=True)
        grid.attach(self.url_entry, 1, 0, 1, 1)

        paste_button = Gtk.Button(label="Paste URL from Clipboard")
        paste_button.connect("clicked", self.paste_url_from_clipboard)
        grid.attach(paste_button, 2, 0, 1, 1)

        # Output Folder Entry
        output_label = Gtk.Label(label="Output Folder:", xalign=0)
        grid.attach(output_label, 0, 1, 1, 1)

        self.output_entry = Gtk.Entry(hexpand=True)
        grid.attach(self.output_entry, 1, 1, 1, 1)

        select_folder_button = Gtk.Button(label="Select Output Folder")
        select_folder_button.connect("clicked", self.select_folder)
        grid.attach(select_folder_button, 2, 1, 1, 1)

        # Output Filename Entry
        filename_label = Gtk.Label(label="Output Filename:", xalign=0)
        grid.attach(filename_label, 0, 2, 1, 1)

        self.filename_entry = Gtk.Entry(hexpand=True)
        grid.attach(self.filename_entry, 1, 2, 1, 1)

        # Format Selection Dropdown
        self.format_combo = Gtk.ComboBoxText()
        self.format_combo.append_text("Convert to MP3")
        self.format_combo.append_text("Download as MP4")
        self.format_combo.set_active(0)
        grid.attach(self.format_combo, 2, 2, 1, 1)

        # Resolution and Audio Quality Side by Side, right below Output Filename
        res_audio_hbox = Gtk.Box(orientation=Gtk.Orientation.HORIZONTAL, spacing=10)
        vbox.pack_start(res_audio_hbox, False, False, 0)

        resolution_label = Gtk.Label(label="Select Resolution (MP4):")
        res_audio_hbox.pack_start(resolution_label, False, False, 0)

        self.resolution_combo = Gtk.ComboBoxText()
        self.resolution_combo.append_text("1080p")
        self.resolution_combo.append_text("720p")
        self.resolution_combo.append_text("480p")
        self.resolution_combo.append_text("360p")
        self.resolution_combo.append_text("240p")
        self.resolution_combo.set_active(0)
        res_audio_hbox.pack_start(self.resolution_combo, True, True, 0)

        audio_quality_label = Gtk.Label(label="Select Audio Quality (MP3):")
        res_audio_hbox.pack_start(audio_quality_label, False, False, 0)

        self.audio_quality_combo = Gtk.ComboBoxText()
        self.audio_quality_combo.append_text("320kbps")
        self.audio_quality_combo.append_text("256kbps")
        self.audio_quality_combo.append_text("192kbps")
        self.audio_quality_combo.append_text("128kbps")
        self.audio_quality_combo.append_text("64kbps")
        self.audio_quality_combo.set_active(2)
        res_audio_hbox.pack_start(self.audio_quality_combo, True, True, 0)

        # Add playlist checkbox
        self.playlist_check = Gtk.CheckButton(label="Download Entire Playlist")
        self.playlist_check.connect("toggled", self.toggle_filename_entry)
        res_audio_hbox.pack_start(self.playlist_check, False, False, 10)

        # Status Label
        self.status_label = Gtk.Label(label="")
        vbox.pack_start(self.status_label, False, False, 0)

        # hbox to hold the buttons
        hbox_controls2 = Gtk.Box(orientation=Gtk.Orientation.HORIZONTAL, spacing=10)
        hbox_controls2.set_halign(Gtk.Align.FILL)
        hbox_controls2.set_hexpand(True)

        # Download Button
        download_button = Gtk.Button(label="Download")
        download_button.connect("clicked", self.download_video)
        download_button.set_hexpand(True)
        hbox_controls2.pack_start(download_button, True, True, 0)

        # Stop Download Button
        stop_download_button = Gtk.Button(label="Stop Download")
        stop_download_button.connect("clicked", self.stop_download)
        stop_download_button.set_hexpand(True) 
        hbox_controls2.pack_start(stop_download_button, True, True, 0)

        # Add hbox_controls2 at the bottom of the VBox
        vbox.pack_end(hbox_controls2, False, False, 0)

        self.download_process = None  # Store the subprocess reference
        self.should_stop_download = False

    def paste_url_from_clipboard(self, widget):
        clipboard = Gtk.Clipboard.get(Gdk.SELECTION_CLIPBOARD)
        url = clipboard.wait_for_text()
        if url:
            self.url_entry.set_text(url)

    def select_folder(self, widget):
        dialog = Gtk.FileChooserDialog(title="Select Output Folder", action=Gtk.FileChooserAction.SELECT_FOLDER)
        dialog.add_buttons(Gtk.STOCK_CANCEL, Gtk.ResponseType.CANCEL, Gtk.STOCK_OPEN, Gtk.ResponseType.OK)

        if dialog.run() == Gtk.ResponseType.OK:
            folder = dialog.get_filename()
            self.output_entry.set_text(folder)

        dialog.destroy()

    def toggle_filename_entry(self, widget):
        is_checked = widget.get_active()
        self.filename_entry.set_sensitive(not is_checked)
        if is_checked:
            self.filename_entry.set_text("")

    def update_status(self, message):
        GLib.idle_add(self.status_label.set_text, message)

    def stop_download(self, widget):
        if self.download_process:
            self.should_stop_download = True
            self.download_process.terminate()  # Terminate the download process
            self.update_status("Download stopped manually.")
        else:
            self.update_status("No active download to stop.")

    def run_yt_dlp(self, command, output_filename):
        self.download_process = subprocess.Popen(command, stdout=subprocess.PIPE, stderr=subprocess.STDOUT, text=True)

        self.set_title(f"Now downloading...")
        for line in self.download_process.stdout:
            if self.should_stop_download:
                break
            self.update_status(line.strip())

        self.download_process.wait()

        if not self.should_stop_download and self.download_process.returncode == 0:
            self.update_status("Download completed successfully.")
        elif self.should_stop_download:
            self.update_status("Download stopped.")
        else:
            self.update_status("Download failed, make sure to input a valid URL.")

        self.set_title("YouTube Video Downloader & Converter")
        self.download_process = None

    def download_video(self, widget):
        self.should_stop_download = False
        url = self.url_entry.get_text()
        output_folder = self.output_entry.get_text()
        output_filename = self.filename_entry.get_text()
        output_format = self.format_combo.get_active_text()
        resolution = self.resolution_combo.get_active_text()
        audio_quality = self.audio_quality_combo.get_active_text()
        download_playlist = self.playlist_check.get_active()

        if not output_filename:
            output_filename='%(title)s'

        if not url or not output_folder:
            self.update_status("Error: Please fill in the URL and the output folder.")
            return

        # Construct yt-dlp command based on format
        common_options = []
        if not download_playlist:
            common_options.append("--no-playlist")

        if output_format == "Convert to MP3":
            command = [
                "yt-dlp", "-f", "bestaudio", url,
                "--extract-audio", "--audio-format", "mp3",
                "--audio-quality", audio_quality,
                "-o", os.path.join(output_folder, f"{output_filename}.%(ext)s")
            ] + common_options
        elif output_format == "Download as MP4":
            format_code = f"bestvideo[height<={resolution[:-1]}]+bestaudio/best"
            command = [
                "yt-dlp", "-f", format_code, url,
                "-o", os.path.join(output_folder, f"{output_filename}.%(ext)s"),
                "--merge-output-format", "mp4"
            ] + common_options
        else:
            self.update_status("Error: Unsupported format selected.")
            return

        # Run yt-dlp in a separate thread
        threading.Thread(target=self.run_yt_dlp, args=(command, output_filename)).start()

# Start the application
win = YouTubeDownloader()
win.connect("destroy", Gtk.main_quit)
win.show_all()
Gtk.main()
