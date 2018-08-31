package gui;

import assembulator.Assembler;
import assembulator.Assembulator;
import gui.factories.*;
import javafx.beans.value.ChangeListener;
import javafx.event.ActionEvent;
import javafx.event.EventHandler;
import javafx.scene.control.*;

import java.io.File;
import java.io.IOException;
import java.util.List;

public class GUI{

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
        List<EventHandler<ActionEvent>> actions = List.of((e)->go(),
                e->assignField(input, DialogFactory.fileLoadChooser("MIPS code", "*.s")),
                e->assignField(output, DialogFactory.fileSaveChooser("MIPS code", "*.s")));
        for(int i = 0; i < labels.size(); ++i)
            buttons.add(ButtonFactory.getInstance(labels.get(i), actions.get(i)));
    }

    private void buildCheckBoxes() {
        List<String> labels = List.of();
        List<ChangeListener<Boolean>> listeners = List.of();
        for(int i = 0; i < labels.size(); ++i)
            checkBoxes.add(CheckboxFactory.getInstance(labels.get(i), listeners.get(i)));
    }

    private void buildMenuBar() {
        List<String> labels = List.of("File", "Edit");
        List<List<String>> menuHeadings = List.of(List.of("Code guard level", "Overwrite existing files", "Clear log on run?"),
                List.of("Reset log"));
        List<List<List<EventHandler<ActionEvent>>>> menuOptions = List.of();
        topBar = MenuBarFactory.getInstance(labels, menuHeadings, menuOptions);
    }

    private void buildTextFields() {
        input = TextFieldFactory.getInstance("Input file/directory");
        output = TextFieldFactory.getInstance("Output directory");
    }

    private void assignField(TextField tf, File f){
        if(f == null) return;
        try{
            String path = f.getCanonicalPath();
            tf.setText(path);
        } catch (IOException e){
            DialogFactory.showError(e);
        }
    }

    private void go(){

    }

}
