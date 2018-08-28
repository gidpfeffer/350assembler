package gui;

import assembulator.Assembler;
import assembulator.Assembulator;
import gui.factories.TextFieldFactory;
import javafx.event.ActionEvent;
import javafx.event.WeakEventHandler;
import javafx.scene.control.*;
import java.util.List;

public class GUI {

    private TextField input ;
    private TextField output;
    private MenuBar topBar;
    private List<Button> buttons;
    private List<CheckBox> checkBoxes;
    private Assembler assembler = new Assembulator();

    public GUI(){
        init();
    }

    private void init(){
        buildTextFields();
        buildMenuBar();
        buildCheckBoxes();
        buildButtons();
    }

    private void buildButtons() {
        List<String> labels = List.of("Launch", "...", "...");
        List<WeakEventHandler<ActionEvent>> actions = List.of();
    }

    private void buildCheckBoxes() {

    }

    private void buildMenuBar() {
    }

    private void buildTextFields() {
        input = TextFieldFactory.getInstance("Input file/directory");
        output = TextFieldFactory.getInstance("Output directory");
    }


}
