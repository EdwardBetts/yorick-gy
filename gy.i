/*
    Copyright 2013 Thibaut Paumard

    This file is part of gy (GObject Introspection for Yorick).

    Gyoto is free software: you can redistribute it and/or modify
    it under the terms of the GNU General Public License as published by
    the Free Software Foundation, either version 3 of the License, or
    (at your option) any later version.

    Gyoto is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
    GNU General Public License for more details.

    You should have received a copy of the GNU General Public License
    along with gy.  If not, see <http://www.gnu.org/licenses/>.
 */

#include "gy0.i"

local gy_i;
/* DOCUMENT #include "gy.i"

    gy is a Yorick plug-in around GObject-introspection. It can
    notably be used to create Gtk GUIs from within Yorick.

    gy_gtk.i contains convenience code for using the Gtk library
    through gy.

   NAMESPACES
    Any library providing gobject-introspection can be accessed
    through this plug-in, as long as the gobject-introspection
    repository (GIR) files are installed on the system: under certain
    Linux systems, the corresponding package may be called
    "gir1.0-<libname>" or something similar. The notable example is
    Gtk.

    To load the GIR bindings for a given library, simply append the
    library's namespace to gy:
      Gtk = gy.Gtk;
    To load a specific version of a namespace (good idea for public
    code):
      Gtk = gy.require("Gtk", "3.0");

    You can use gy_list to list the symbols inside this
    namespace:
      gy_list, Gtk;

   TYPE CLASSES AND OBJECTS
    A namespace (Gtk in this example) contains the definition of
    various types (object classes, C structures, enums...).
  
    Although some object classes provide one or several "new()"
    methods, the normal way is to just call the (object or structure)
    class as a function, passing properties or fields as keywords:
      button = gy.Gtk.Button.new_with_label("My Button");
    is thus equivalent to
      button = gy.Gtk.Button(label="My Button");
      
    Object members can also be listed with gy_list:
      gy_list, button;
      gy_list, Gtk.Button;
    (This only lists the available members and methods, not their
    value).

    Object/structure properties and fields can be set using the
    keyword notation, although specific "set_" methods are often
    provided:
      noop, button.set_label("other label");
      button, label="other label";
    They can be retrieved with either of:
      var = button.label;
      val = button.get_label(); // if applicable
      button, label, var;
    The last form is convenient and performant when retrieving several
    properties at a time:
      button, xalign, x, yalign, y;
    Hyphens in properties or filed names in the C documentation are
    replaced with underscores in the Yorick implementation.

    Methods and other member functions are accessed by extracting them
    with the dot operator (which produces a closure), then calling the
    closure. In simpler words, this works as expected:
      object.method(arguments);
    Note that the coma syntax does not work in this context. The two
    following are equivalent to hide the output value from a method
    call:
      closure = object.method; closure, arguments;
      noop, object.method(arguments);

    Enum values are accessed likewise:
      var = gy.Gtk.MessageType.error;
    Beware that C documentation may list enum values are CPP
    macros. Those aliases are not accessible within Yorick, only the
    fully qualified name. For instance, GTK_MESSAGE_ERROR is one value
    of type GtkMessageType. In Yorick you access it as
    gy.Gtk.MessageType.error.
    
    
    Callbacks can be connected to objects using gy_signal_connect.

    gy simply exposes conforming library content to Yorick. See the
    relevant library C API documentation for more details, for
    instance:
      https://developer.gnome.org/gtk3/stable/
    
    
   SEE ALSO: gy, gy_gtk_i
 */

extern gy;
/* DOCUMENT gy

    gy is a Yorick plug-in around GObject-introspection. It can
    notably be used to create Gtk GUIs from within Yorick. See gy_i
    for an introduction.

    The gy object itself gives access to the gobject introspection
    repository. It serves only one purpose: loading so called
    "namespace", which can be done very simply by dereferencing gy:
      Gtk = gy.Gtk;
    It is safer to use the "require" method below though.

   METHODS:
    require: allows loading a specific version of a namespace:
                  Gtk = gy.require("Gtk", "3.0");
             only one given version of a namespace can be loaded at a
             given time.
             
    require_private, get_search_path, prepend_search_path,
    is_registered, get_version, enumerate_versions: see C
    documentation for g_irepository_<method>.

   SEE ALSO: gy_i, gy_init, gy_list
    
 */
gy=gy_init();
