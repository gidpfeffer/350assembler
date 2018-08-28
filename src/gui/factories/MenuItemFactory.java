package gui.factories;


import javafx.event.ActionEvent;
import javafx.event.EventHandler;
import javafx.scene.control.MenuItem;

public class MenuItemFactory {

    public static MenuItem getInstance(String label, EventHandler<ActionEvent> action){
        MenuItem mi = new MenuItem(label);
        mi.setOnAction(action);
        return mi;
    }
}
