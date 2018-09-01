package gui;

import assembulator.Assembler;
import assembulator.Assembulator;
import gui.factories.*;
import javafx.beans.value.ChangeListener;
import javafx.event.ActionEvent;
import javafx.event.EventHandler;
import javafx.geometry.Insets;
import javafx.scene.Group;
import javafx.scene.Scene;
import javafx.scene.control.*;
import javafx.scene.control.Button;
import javafx.scene.control.MenuBar;
import javafx.scene.control.TextArea;
import javafx.scene.control.TextField;
import javafx.scene.image.Image;
import javafx.scene.image.ImageView;
import javafx.scene.layout.BorderPane;
import javafx.scene.layout.VBox;
import javafx.stage.Stage;

import java.io.*;
import java.util.*;
import java.util.List;

public class GUI implements Executable{

    public static final int PREF_SIZE = 500;
    public static final int PADDING = 10;

    private TextField input ;
    private TextField output;
    private MenuBar topBar;
    private List<Button> buttons = new ArrayList<>();
    private Map<String, ChangeListener<Boolean>> listenerMap = new HashMap<>();
    private Group root = new Group();
    private BorderPane bp = new BorderPane();
    private Assembler assembler = new Assembulator();
    private TextArea log = new TextArea();
    private ImageView title = new ImageView(new Image(this.getClass().getClassLoader().getResourceAsStream("350_Assembler.png")));

    public GUI(Stage s){
        init();
        bp.setPrefHeight(PREF_SIZE);
        bp.setPrefWidth(PREF_SIZE);
        bp.setPadding(new Insets(PADDING));
        log.setEditable(false);
        log.setPrefSize(0.9 * PREF_SIZE, 0.4 * PREF_SIZE);
        var masterPane = new BorderPane();
        var barPane = new BorderPane();
        barPane.setTop(topBar);
        masterPane.setTop(barPane);
        masterPane.setBottom(bp);
        Scene scene = new Scene(masterPane);
        s.setScene(scene);
        s.show();
    }

    private void init(){
        buildTextFields();
        buildMenuBar();
        buildButtons();
        BorderPane p = new BorderPane();
        BorderPane but = new BorderPane();
        but.setRight(buttons.get(0));
        //bp.setTop(topBar);
        BorderPane logoPane = new BorderPane();
        logoPane.setCenter(title);
        bp.setTop(logoPane);
        title.setPreserveRatio(true);
        title.setFitWidth(0.8 * PREF_SIZE);
        root.getChildren().add(p);
        bp.setBottom(log);
        var in = packageTextAndButton(input, buttons.get(1));
        var out = packageTextAndButton(output, buttons.get(2));
        var center = new VBox();
        center.getChildren().add(in);
        center.getChildren().add(out);
        center.getChildren().add(but);
        bp.setCenter(center);
    }

    private VBox packageTextAndButton(TextField tf, Button b){
        VBox ret = new VBox();
        ret.setPadding(new Insets(PADDING));
        ret.getChildren().add(tf);
        ret.getChildren().add(b);
        return ret;
    }

    private void buildButtons() {
        List<String> labels = List.of("Launch", "...", "...");
        List<EventHandler<ActionEvent>> actions = List.of((e)->go(),
                e->assignField(input, DialogFactory.fileLoadChooser("MIPS code", "*.s")),
                e->assignField(output, DialogFactory.fileSaveChooser()));
        for(int i = 0; i < labels.size(); ++i)
            buttons.add(ButtonFactory.getInstance(labels.get(i), actions.get(i)));
    }

    private void buildMenuBar() {
        List<String> structure = List.of(
                MenuBarFactory.MENU, "File",
                    MenuBarFactory.MENU, "Protection Level",
                        MenuBarFactory.MENU_ITEM, MenuItemFactory.CHECK_MENU, "Pad all",
                        MenuBarFactory.MENU_ITEM, MenuItemFactory.CHECK_MENU, "No padding",
                    MenuBarFactory.BREAK,
                    MenuBarFactory.MENU_ITEM, MenuItemFactory.CHECK_MENU, "Overwrite files?",
                    MenuBarFactory.MENU_ITEM, MenuItemFactory.CHECK_MENU, "Search subdirs?",
                    MenuBarFactory.MENU_ITEM, MenuItemFactory.CHECK_MENU, "Add output dir?",
                MenuBarFactory.BREAK,
                MenuBarFactory.MENU, "Edit",
                    MenuBarFactory.MENU_ITEM, MenuItemFactory.DEFAULT_MENU, "Clear log",
                MenuBarFactory.BREAK
        );
        listenerMap.put("Overwrite", new MenuListener<>());
        listenerMap.put("all", new MenuListener<>());
        listenerMap.put("none", new MenuListener<>());
        listenerMap.put("subdirs", new MenuListener<>());
        listenerMap.put("outdir", new MenuListener<>());
        List<ChangeListener<Boolean>> listeners = List.of(listenerMap.get("Overwrite"),
                listenerMap.get("all"), listenerMap.get("none"),
                listenerMap.get("subdirs"), listenerMap.get("outdir"));
        List<EventHandler<ActionEvent>> handlers = List.of(e->log.clear());
        topBar = MenuBarFactory.getInstance(structure, listeners, handlers);
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
    @Override
    public void go(){
        String inString = input.getText();
        String outString = output.getText();
        if(inString.isEmpty() || outString.isEmpty()){
            DialogFactory.showError("Must specify input and output locations.");
            return;
        }
        File in = new File(inString);
        File out = new File(outString);
        try {
            if (in.isDirectory() && out.isDirectory()) {
                encodeAllFiles(in, out);
            } else if (!in.isDirectory() && out.isDirectory()) {
                writeFile(new FileInputStream(in), new FileOutputStream(getOutputFileFromDirectory(out, in.getName())));
            } else if (!in.isDirectory() && !out.isDirectory()) {
                writeFile(new FileInputStream(in), new FileOutputStream(out));
            }
        } catch(IOException e){
            DialogFactory.showError(e);
        }
    }

    private void encodeAllFiles(File in, File out){
        try {
            for (File file : in.listFiles()) {
                String name = file.getName();
                File outputFile = getOutputFileFromDirectory(out, name);
                writeFile(new FileInputStream(file), new FileOutputStream(outputFile));
            }
        }catch(IOException e){
            DialogFactory.showError(e);
        }
    }

    private File getOutputFileFromDirectory(File out, String name) throws IOException {
        return new File(String.join(File.separator, out.getCanonicalPath(), name));
    }

    private void writeFile(FileInputStream fis, FileOutputStream out){
        assembler.writeTo(fis, out);
    }

}
