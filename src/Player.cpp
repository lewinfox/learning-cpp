#include "Player.h"

Player::Player()
    : player_id{0}, name{"Unknown Player"}, health{10}, xp{0}
{
    std::cout << "Player " << name << " created" << std::endl;
}

Player::Player(std::string name_val)
    : player_id{0}, name{name_val}, health{10}, xp{0}
{
    std::cout << "Player " << name << " created" << std::endl;
}

Player::Player(std::string name_val, int health_val)
    : player_id{0}, name{name_val}, health{health_val}, xp{0}
{
    std::cout << "Player " << name << " created" << std::endl;
}

Player::Player(std::string name_val,int health_val, int xp_val)
    : player_id{0}, name{name_val}, health{health_val}, xp{xp_val}
{
    std::cout << "Player " << name << " created" << std::endl;
}

Player::~Player()
{
    std::cout << "Destructor called for " << name << std::endl;
}

void Player::take_damage(int damage)
{
    health -= damage;
}

void Player::say(std::string what_to_say)
{
    std::cout << name << ": " << what_to_say << std::endl;
}

void Player::gain_health(int health_to_gain)
{
    health += health_to_gain;
}

int Player::get_health()
{
    return health;
}

bool Player::is_alive()
{
    return health > 0;
}

void Player::set_name(std::string new_name)
{
    name = new_name;
}
