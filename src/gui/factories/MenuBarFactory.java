package gui.factories;

import javafx.beans.value.ChangeListener;
import javafx.event.ActionEvent;
import javafx.event.EventHandler;
import javafx.scene.control.Menu;
import javafx.scene.control.MenuBar;
import javafx.scene.control.MenuItem;

import java.util.Arrays;
import java.util.List;
import java.util.Map;
import java.util.Stack;

public class MenuBarFactory {

    public static final String BREAK = "BREAK";
    public static final String MENU_ITEM = "menuItem";
    public static final String MENU = "menu";
    public static final String ERROR = "Bad argument list -- %s is not of type %s";

    public static MenuBar getInstance(){
        return new MenuBar();
    }

    @SuppressWarnings("unchecked")
    public static MenuBar getInstance(List<Object> menuTree){
        Stack<Menu> s = new Stack<>();
        MenuBar mb = new MenuBar();
        // Do a DFS for nested menus
        for (int i = 0; i < menuTree.size(); ++i) {
            String entry;
            if(!(menuTree.get(i) instanceof String)){
                entry = (String) menuTree.get(i);
            }
            else throw new IllegalArgumentException(String.format(ERROR, menuTree.get(i).getClass().toString(), "String"));
            switch (entry) {
                case MENU: {
                    Menu m;
                    if(menuTree.get(++i) instanceof String)
                        m = MenuFactory.getInstance(menuTree.get(i).toString());
                    else throw new IllegalArgumentException(String.format(ERROR, menuTree.get(i).getClass().toString(), "String"));
                    if(s.isEmpty()){ // At the root level since nothing is on the stack -- add this menu directly to the bar
                        mb.getMenus().add(m);
                    }
                    else { // This menu belongs to another menu already, so add it as a child
                        Menu parent = s.peek();
                        parent.getItems().add(m);
                    }
                    s.push(m);
                    break;
                }
                case MENU_ITEM: {
                    MenuItem mi;
                    if(menuTree.get(++i) instanceof String && menuTree.get(++i) instanceof String)
                        mi = MenuItemFactory.getInstance(menuTree.get(i-1).toString(), menuTree.get(i).toString(), menuTree.get(++i));
                    else throw new IllegalArgumentException(String.format(ERROR, menuTree.get(i).getClass().toString(), "String"));
                    Menu m = s.peek();
                    m.getItems().add(mi);
                    break;
                }
                case BREAK: // We're coming back up the tree, so this menu has no more children
                    s.pop();
                    break;
                default:
                    throw new IllegalArgumentException("Unrecognized menu type");
            }

        }
        return mb;
    }

    public static MenuBar getInstance(List<String> menuTitles, List<List<String>> subMenuLabels,
                                      List<List<List<EventHandler<ActionEvent>>>> subMenuActions){
        if(menuTitles.size() != subMenuLabels.size() || subMenuLabels.size() != subMenuActions.size())
            throw new IllegalArgumentException("Size mismatch for menu titles, labels, or actions");
        MenuBar mb = getInstance();
        //addMenus(menuTitles, subMenuLabels, subMenuActions, mb);
        return mb;
    }

    private static void addMenus(List<String> menuTitles, List<List<String>> subMenuLabels,
                                 List<List<EventHandler<ActionEvent>>> subMenuActions, MenuBar mb) {
        for(int i = 0; i < subMenuLabels.size(); ++i){
            String menuTitle = menuTitles.get(i);
            var labels = subMenuLabels.get(i);
            var actions = subMenuActions.get(i);
            mb.getMenus().add(MenuFactory.getInstance(menuTitle, labels, actions));
        }
    }
}
