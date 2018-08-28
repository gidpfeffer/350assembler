package gui.factories;

import javafx.event.ActionEvent;
import javafx.event.EventHandler;
import javafx.scene.control.MenuBar;

import java.util.List;

public class MenuBarFactory {

    public static MenuBar getInstance(){
        return new MenuBar();
    }

    public static MenuBar getInstance(List<String> menuTitles, List<List<String>> subMenuLabels,
                                      List<List<EventHandler<ActionEvent>>> subMenuActions){
        if(menuTitles.size() != subMenuLabels.size() || subMenuLabels.size() != subMenuActions.size())
            throw new IllegalArgumentException("Size mismatch for menu titles, labels, or actions");
        MenuBar mb = getInstance();
        addMenus(menuTitles, subMenuLabels, subMenuActions, mb);
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
