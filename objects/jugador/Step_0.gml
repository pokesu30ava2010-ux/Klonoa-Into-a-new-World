//======================================
// INPUTS
//======================================

var move_input = 0;
var jump_pressed = keyboard_check_pressed(vk_space);
var lose_hp = keyboard_check_pressed(ord("K"));
var gain_hp = keyboard_check_pressed(ord("L"));
var restart_pressed = keyboard_check_pressed(ord("R"));

// Teclado
if (keyboard_check(ord("D"))) move_input += 1;
if (keyboard_check(ord("A"))) move_input -= 1;
//======================================
// MUERTE
//======================================

if (muerto)
{
    xspd = 0;
    yspd = 0;

    if (sprite_index != spr_player_dead)
    {
        sprite_index = spr_player_dead;
        image_index = 0;
    }

    image_speed = 1;

    if (restart_pressed)
    {
        x = spawn_x;
        y = spawn_y;

        hp = max_hp;
        muerto = false;
    }

    exit;
}

if (hp <= 0)
{
    muerto = true;
}

//======================================
// MOVIMIENTO HORIZONTAL
//======================================

xspd = move_input * move_speed;

repeat(abs(xspd))
{
    if (!place_meeting(x + sign(xspd), y, obj_colision))
    {
        x += sign(xspd);
    }
    else
    {
        break;
    }
}

//======================================
// VOLTEAR SPRITE
//======================================

if (xspd > 0)
{
    image_xscale = 2;
}
else if (xspd < 0)
{
    image_xscale = -2;
}

//======================================
// DETECCIÓN DE SUELO
//======================================

var en_suelo = place_meeting(x, y + 1, obj_colision);

//======================================
// SALTO
//======================================

if (en_suelo && jump_pressed)
{
    yspd = jump_speed;
}

//======================================
// GRAVEDAD
//======================================

yspd += grav;

//======================================
// MOVIMIENTO VERTICAL
//======================================

if (yspd < 0)
{
    repeat(abs(ceil(yspd)))
    {
        if (!place_meeting(x, y - 1, obj_colision))
        {
            y -= 1;
        }
        else
        {
            yspd = 0;
            break;
        }
    }
}

if (yspd > 0)
{
    repeat(ceil(yspd))
    {
        if (!place_meeting(x, y + 1, obj_colision))
        {
            y += 1;
        }
        else
        {
            yspd = 0;
            break;
        }
    }
}

// Recalcular suelo
en_suelo = place_meeting(x, y + 1, obj_colision);

//======================================
// ANIMACIONES
//======================================

if (!en_suelo)
{
    if (yspd < 0)
    {
        if (sprite_index != spr_player_jump)
        {
            sprite_index = spr_player_jump;
            image_index = 0;
        }
    }
    else
    {
        if (sprite_index != spr_player_fall)
        {
            sprite_index = spr_player_fall;
            image_index = 0;
        }
    }

    image_speed = 1;
}
else
{
    if (xspd != 0)
    {
        if (sprite_index != spr_player_walk)
        {
            sprite_index = spr_player_walk;
            image_index = 0;
        }
    }
    else
    {
        if (sprite_index != spr_player_stand)
        {
            sprite_index = spr_player_stand;
            image_index = 0;
        }
    }

    image_speed = 1;
}

//======================================
// VIDA TEST
//======================================

if (lose_hp)
{
    hp -= 1;
    hp = clamp(hp, 0, max_hp);
}

if (gain_hp)
{
    hp += 1;
    hp = clamp(hp, 0, max_hp);
}
