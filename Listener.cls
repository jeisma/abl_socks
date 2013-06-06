 

using Progress.Lang.*.
using Progress.Windows.Form.



class Listener inherits Form: 
	
	define private variable components as System.ComponentModel.IContainer no-undo.
	
   def private var server as utils.SocketServer. 
		
	constructor public Listener (  ):				
		
        super().
        
        server = new utils.SocketServer('23456'). 
        
        InitializeComponent().
        this-object:ComponentsCollection:ADD(this-object:components).
        catch e as Progress.Lang.Error:
            undo, throw e.
        end catch.

	end constructor.

	method private void InitializeComponent(  ):
		
        /* NOTE: The following method is automatically generated.
        
        We strongly suggest that the contents of this method only be modified using the
        Visual Designer to avoid any incompatible modifications.
        
        Modifying the contents of this method using a code editor will invalidate any support for this file. */
        this-object:SuspendLayout().
        this-object:Name = "Listener".
        this-object:Text = "Listener".
        this-object:ResumeLayout(false).
        catch e as Progress.Lang.Error:
            undo, throw e.
        end catch.

	end method.

	destructor public Listener ( ):
      delete object server.
	end destructor.

end class.
