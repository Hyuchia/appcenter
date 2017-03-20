// -*- Mode: vala; indent-tabs-mode: nil; tab-width: 4 -*-
/*-
* Copyright (c) 2016 elementary LLC. (https://elementary.io)
*
* This program is free software: you can redistribute it and/or modify
* it under the terms of the GNU General Public License as published by
* the Free Software Foundation, either version 3 of the License, or
* (at your option) any later version.
*
* This program is distributed in the hope that it will be useful,
* but WITHOUT ANY WARRANTY; without even the implied warranty of
* MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
* GNU General Public License for more details.
*
* You should have received a copy of the GNU General Public License
* along with this program.  If not, see <http://www.gnu.org/licenses/>.
*
* Authored by: Nathan Dyer <mail@nathandyer.me>
*              Dane Henson <thegreatdane@gmail.com>
*/

namespace AppCenter {
    public class Homepage: Gtk.Box {

        public signal void package_selected (AppCenterCore.Package package);

        public Widgets.Banner newest_banner;
        public AppCenter.Views.CategoryView category_view;
        private Gtk.ScrolledWindow scrolled_window;

        public Homepage () {
            var houston = AppCenterCore.Houston.get_default ();

            scrolled_window = new Gtk.ScrolledWindow (null, null);
            var scrolled_box = new Gtk.Box (Gtk.Orientation.VERTICAL, 12);
            var banner_box = new Gtk.Box (Gtk.Orientation.VERTICAL, 12);

            newest_banner = new Widgets.Banner ();
            newest_banner.get_style_context ().add_class ("home");
            newest_banner.margin = 24;

            var newest_ids = houston.get_newest ();
            int i = 0;
            while (newest_ids.length > 0 && i < newest_ids.length) {
                var candidate = newest_ids[i] + ".desktop";
                var candidate_package = AppCenterCore.Client.get_default ().get_package_for_id (candidate);
                if (candidate_package != null && candidate_package.state != AppCenterCore.Package.State.INSTALLED) {
                    newest_banner.set_package (candidate_package);
                    newest_banner.clicked.connect (() => {
                        package_selected (candidate_package);
                    });
                    i = newest_ids.length;
                } else {
                    i++;
                }
            }
            if (newest_banner.current_package == null) {
                newest_banner.set_brand ();
            }
            banner_box.add (newest_banner);

            var recent_box = new Gtk.Box (Gtk.Orientation.HORIZONTAL, 0);
            var recent_label = new Gtk.Label ("Recent");
            recent_label.get_style_context ().add_class ("h4");
            recent_label.xalign = 0;

            var recent_more_button_label = new Gtk.Label (_("<small>More</small>"));
            recent_more_button_label.use_markup = true;
            var recent_more_button = new Gtk.Button ();
            recent_more_button.add (recent_more_button_label);
            recent_more_button.halign = Gtk.Align.END;
            recent_more_button.valign = Gtk.Align.CENTER;
            recent_box.add (recent_label);
            recent_box.add (recent_more_button);
            recent_box.homogeneous = true;
            recent_box.margin_left = 24;
            recent_box.margin_right = 24;

            var recent_carousel = new Widgets.AppCarousel ();
            recent_carousel.margin_left = 12;
            recent_carousel.margin_right = 12;

            var categories_label = new Gtk.Label ("Categories");
            categories_label.get_style_context ().add_class ("h4");
            categories_label.xalign = 0;
            categories_label.margin_left = 24;

            category_view = new Views.CategoryView ();

            scrolled_box.add (banner_box);
            scrolled_box.add (recent_box);
            scrolled_box.add (recent_carousel);
            scrolled_box.add (categories_label);
            scrolled_box.add (category_view.category_flow);

            scrolled_window.add (scrolled_box);
            this.add (scrolled_window);

            update_latest_row ();
        }

        public async void update_latest_row () {
            var client = AppCenterCore.Client.get_default ();
            var latest_packages = yield client.get_latest_packages ();
            foreach (var pk_package in latest_packages) {
                stdout.printf ("LATEST: %s\n", pk_package.get_name ());
            }
        }
    }
}
