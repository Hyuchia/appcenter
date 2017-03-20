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
*/

namespace AppCenter.Widgets {

    public class AppCarousel : Gtk.Box {

        // public  AppCarousel (Gee.Collection<AppCenterCore.Package> packages)
        public AppCarousel () {

            var main_content = new Gtk.Box (Gtk.Orientation.HORIZONTAL, 0);
            main_content.homogeneous = true;
            main_content.expand = true;

            /*
            foreach (AppCenterCore.Package in packages) {

            var carousel_item_box = new Gtk.Box (Gtk.Orientation.HORIZONTAL, 0);

            Gtk.Image app_image = new Gtk.Image.from_gicon (package.get_icon (), Gtk.IconSize.DIALOG);
            app_image.margin_right = 12;

            var package_information_box = new Gtk.Box (Gtk.Orientation.VERTICAL, 0);
            var package_name_label = new Gtk.Label (package.get_name ());
            package_name_label.xalign = 0;

            // TODO: get the category from the package
            var category_label = new Gtk.Label ("Category");
            category_label.sensitive = false;
            category_label.xalign = 0;
            package_information_box.valign = Gtk.Align.CENTER;
            package_information_box.pack_start (package_name_label, false, false, 0);
            package_information_box.pack_start (category_label, false, false, 0);

            carousel_item_box.pack_start (app_image, false, false, 0);
            carousel_item_box.pack_start (package_information_box, false, false, 0);

            var carousel_item_button = new Gtk.Button ();
            carousel_item_button.get_style_context ().remove_class ("button");
            carousel_item_button.margin_right = 12;
            carousel_item_button.margin_left = 12;
            carousel_item_button. add (carousel_item_box);
            main_content.add (carousel_item_button);
            */

            for (int i = 0; i < 5; i++) {
              var carousel_item_box = new Gtk.Box (Gtk.Orientation.HORIZONTAL, 0);

              Gtk.Image app_image = new Gtk.Image.from_icon_name ("application-default-icon", Gtk.IconSize.DIALOG);
              app_image.margin_right = 12;

              var package_information_box = new Gtk.Box (Gtk.Orientation.VERTICAL, 0);
              var package_name_label = new Gtk.Label ("App Name");
              package_name_label.xalign = 0;
              var category_label = new Gtk.Label ("Category");
              category_label.sensitive = false;
              category_label.xalign = 0;
              package_information_box.valign = Gtk.Align.CENTER;
              package_information_box.pack_start (package_name_label, false, false, 0);
              package_information_box.pack_start (category_label, false, false, 0);

              carousel_item_box.pack_start (app_image, false, false, 0);
              carousel_item_box.pack_start (package_information_box, false, false, 0);

              var carousel_item_button = new Gtk.Button ();
              carousel_item_button.get_style_context ().remove_class ("button");
              carousel_item_button.margin_right = 12;
              carousel_item_button.margin_left = 12;
              carousel_item_button. add (carousel_item_box);
              main_content.add (carousel_item_button);
            }

            add (main_content);
        }
    }
}
