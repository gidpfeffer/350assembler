package gui.factories;

import javafx.scene.control.TextField;

public class TextFieldFactory {

    public static TextField getInstance(){
        return getInstance("");
    }

    public static TextField getInstance(String contextText){
        TextField tf = new TextField();
        tf.setPromptText(contextText);
        return tf;
    }
}
