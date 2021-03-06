setPlayerSprite();

if (not isOnGround(oSolid)) {	
	speedY += gravityAcceleration;
	
	//Control the jump height
	if (upRelease and speedY < -6) {
		speedY = -3;	
	}
} else {
	speedY = 0;	
	
	//Jumping code
	if (up) {
		speedY = jumpHeight;
		audio_play_sound(aJump, 5, false);
	}
}

if (right) image_xscale = 1;
if (left) image_xscale = -1;
setSpriteDirection(speedX);

if (right or left) {
	speedX += (right - left) * acceleration;
	speedX = clamp(speedX, -maxSpeed, maxSpeed);
} else {
	applyFriction(acceleration); 
}

move(oSolid);

//Landing sound after jump
if (place_meeting(x, y + speedY + 1, oSolid) and speedY > 0) {
	audio_play_sound(aStep, 6, false);
}

if (spacePressed) {
	instance_create_layer(x+32*image_xscale, y, "Instances", oPlayerAttackHitBox);
}
if (enterPressed) {
	instanceCreate(oPlayerShoot, x, y);
}

if (checkForLedgeGrabState()) {
	ledgeGrabStateTransition();
}