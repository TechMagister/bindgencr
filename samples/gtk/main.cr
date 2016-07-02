#include <gtk/gtk.h>

require "./lib_gtk"

def gtk_window(p)
  p as LibGtk::GtkWindow*
end

def g_signal_connect(instance, detailed_signal : String, c_handler, data)
  pt = Pointer(Proc(Nil)).new pointerof(c_handler).address
  LibGtk.g_signal_connect_data(instance, detailed_signal.to_unsafe as Int8*,
  pt.value, data, nil, LibGtk::GConnectFlags::GCONNECTAFTER)
end

activate  = ->( app : LibGtk::GApplication*, user_data : LibGtk::Gpointer)
{
  puts app
  window = LibGtk.gtk_application_window_new(app as LibGtk::GtkApplication*);
  LibGtk.gtk_window_set_title(gtk_window(window), "Window".to_unsafe as Int8*);
  LibGtk.gtk_window_set_default_size(gtk_window(window), 200, 200);
  LibGtk.gtk_widget_show_all(window);
}

app = LibGtk.gtk_application_new("org.gtk.example".to_unsafe as Int8*,
            LibGtk::GApplicationFlags::GAPPLICATIONFLAGSNONE);
g_signal_connect(app, "activate", activate, nil);

argc = ARGV.size

status = LibGtk.g_application_run(app as LibGtk::GApplication*, argc, ARGV_UNSAFE);
LibGtk.g_object_unref(app);