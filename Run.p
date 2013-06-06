using System.Windows.Forms.* from assembly.

DEF VAR f AS Listener.
f = NEW Listener().

f:WindowState = FormWindowState:Minimized.

wait-for Application:Run(f).
