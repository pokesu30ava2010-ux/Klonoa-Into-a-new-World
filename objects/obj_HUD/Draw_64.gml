var p = instance_find(jugador, 0);

if (p != noone)
{
    //======================================
    // CORAZONES
    //======================================
    
    var hp = p.hp;
    var max_hp = p.max_hp;

    for (var i = 0; i < max_hp; i++)
    {
        var xx = 20 + (i * 80);
        var yy = 20;

        if (i < hp)
        {
            draw_sprite_ext(spr_heartfull, 0, xx, yy, 4, 4, 0, c_white, 1);
        }
        else
        {
            draw_sprite_ext(spr_heartempty, 0, xx, yy, 4, 4, 0, c_white, 1);
        }
    }

    //======================================
    // TEXTO DE MUERTE
    //======================================
    
    if (p.muerto)
    {
        draw_set_halign(fa_center);
        draw_set_valign(fa_middle);

        var cx = display_get_gui_width() / 2;
        var cy = display_get_gui_height() * 0.75;

        draw_text(cx, cy - 30, "GAME OVER");
        draw_text(cx, cy + 30, "PRESS R ON KEYBOARD OR LB ON CONTROLLER TO RESTART");

        draw_set_halign(fa_left);
        draw_set_valign(fa_top);
    }
}