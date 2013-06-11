def input param socket as utils.Socket.

procedure client_connect_procedure:
   def input param client_socket_handle  as handle no-undo.

   dynamic-invoke(socket, "client_connect_procedure", client_socket_handle).
end procedure.

/* handles server/client response to read/write requests */
procedure process_io:
   dynamic-invoke(socket, "process_io").
end procedure.
