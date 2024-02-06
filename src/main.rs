use bevy::prelude::*;

fn main() {
    App::new()
        .add_systems(Update, hello_world)
        .add_systems(Startup, add_people)
        .add_systems(Update, greet_people)
        .run();
}

fn hello_world() {
    println!("hello world!");
}

#[derive(Component)]
struct Person;

#[derive(Component)]
struct Name(String);

fn add_people(mut commands: Commands) {
    commands.spawn((Person, Name("Jocke".to_string())));
    commands.spawn((Person, Name("Bror".to_string())));
}

fn greet_people(query: Query<&Name, With<Person>>) {
    for name in &query {
        println!("Hello {}", name.0);
    }
}
