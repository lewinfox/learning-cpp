#include "Player.h"

int main() {
    Player lewin;
    lewin.say("Hello");

    Player troll {"Trollface"};
    troll.say("Raargh");

    Player *wizard = new Player("Wizard", 100);
    wizard->say("Watch me change my name");
    wizard->set_name("Big Wizard");
    wizard->say("I changed it");
    delete wizard;

    return 0;
}
