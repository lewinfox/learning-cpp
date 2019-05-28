#include <string>
#include <iostream>

#ifndef _PLAYER_H_
#define _PLAYER_H_

class Player
{
private:
    int player_id;
    std::string name;
    int health;
    int xp;
public:
    // Constructors
    Player();
    Player(std::string name_val);
    Player(std::string name_val, int health_val);
    Player(std::string name_val, int health_val, int xp_val);
    // Destructor
    ~Player();
    // Methods
    void take_damage(int damage);
    void say(std::string what_to_say);
    void gain_health(int health_to_gain);
    int get_health();
    bool is_alive();
    void set_name(std::string name_val);
};

#endif // _PLAYER_H_
