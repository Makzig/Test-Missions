using Godot;
using System;

public class Start_scene : Control
{
    

    private void OnreadyVarAndConnectSignals()
    {
        GetNode<Button>("VBoxContainer/Play").Connect("pressed", this, "_OnPlayPressed");
        GetNode<Button>("VBoxContainer/Exit").Connect("pressed", this, "_OnExitPressed");
    }
    
    private void _OnExitPressed()
    {
        GetTree().Quit();
    }

    private void _OnPlayPressed()
    {
        GetTree().ChangeScene("res://Scenes/Main.tscn");
    }


    public override void _Ready()
    {
        OnreadyVarAndConnectSignals();   
    }


}
