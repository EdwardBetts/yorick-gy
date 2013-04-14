#include "gy.i"

func __gycmap_init(void) {
  extern __gycmap_initialized, __gycmap_builder, __gycmap_win, __gycmap_ebox;
  noop, gy.Gtk.init(0,);
  gy_setlocale;
  __gycmap_builder = gy.Gtk.Builder.new();
  noop, __gycmap_builder.add_from_file("gycmap.xml");
  __gycmap_win = __gycmap_builder.get_object("window1");
  __gycmap_ebox = __gycmap_builder.get_object("eventbox");
  gy_signal_connect, __gycmap_ebox, "button-press-event", "__gycmap_callback";
  gy_signal_connect, __gycmap_win, "delete_event", "__gyterm_suspend";
  __gycmap_initialized=1;
}

func __gycmap_callback(widget, event) {
  extern ev;
  "button pressed";
  ev = gy.Gdk.EventButton(event);
  ev, x, x, y, y;
  write, format="x=%g, y=%g\n", x, y;
  //noop, gy.Gtk.main_quit();
  //set_idler, __gyterm_idler;
  if (y<20) map="gray";
  else if (y<39) map="yarg";
  else if (y<58) map="heat";
  else if (y<75) map="earth";
  else if (y<94) map="stern";
  else if (y<114) map="rainbow";
  else map="ncar";
  cmap, map;
}

func gycmap(void) {
  extern __gycmap_initialized, __gycmap_builder, __gycmap_win, __gycmap_ebox;
  if (!__gycmap_initilized) __gycmap_init;
  noop, __gycmap_win.show_all();
  noop, gy.Gtk.main();
}
