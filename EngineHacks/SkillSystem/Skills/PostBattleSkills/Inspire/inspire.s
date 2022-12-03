.thumb

.macro blh to, reg=r3
  ldr \reg, =\to
  mov lr, \reg
  .short 0xf800
.endm

  m4aSongNumStart = 0x080D01FC|1

  gActiveUnit = 0x03004E50
  gChapterData = 0x0202BCF0

.type Inspire_PostBattle, function
.global Inspire_PostBattle

.type ApplyRallyEffect, function
.type TryPlaySoundEffect, function
.type RallyAuraCheck, function

Inspire_PostBattle:
  push	{lr}
  @check if dead
  ldrb	r0, [r4,#0x13]
  cmp	r0, #0x00
  beq	Inspire.End

  @check if attacked this turn
  ldrb 	r0, [r6,#0x11]	@action taken this turn
  cmp	r0, #0x2 @attack
  bne	Inspire.End
  ldrb 	r0, [r6,#0x0C]	@allegiance byte of the current character taking action
  ldrb	r1, [r4,#0x0B]	@allegiance byte of the character we are checking
  cmp	r0, r1		@check if same character
  bne	Inspire.End

  @check for skill
  mov	r0, r4
  ldr	r1, =InspireIDLink
  ldr r1, [r1]
  ldr	r3, =SkillTester
  mov	lr, r3
  .short	0xf800
  cmp	r0,#0x00
  beq	Inspire.End

  @rally
  blh RallyAuraCheck
  cmp r0, #0
  beq NoRally
  adr r0, ApplyRallyEffect
  add r0, #1 @ function 
  blh ForEachRalliedUnit
  @blh StartRallyFx @definitely does not work...
  blh TryPlaySoundEffect
  NoRally:

Inspire.End:
  pop	{r0}
  bx	r0

.align
ApplyRallyEffect:
@ r0 unit

push {lr}

blh GetDebuffs @ r0 debuff addr
add r3, r0, #3 @ rally bits
ldrb r0, [r3]
mov r1, #1 @ rally str
orr r0, r1
strb r0, [r3]

pop {r0}
bx r0

.align
TryPlaySoundEffect:
  push {lr}
  ldr  r0, =gChapterData+0x41 @ options
  ldrb r0, [r0]

  lsl r0, r0, #0x1E
  blt NoSound

  ldr r3, =m4aSongNumStart

  mov r0, #136 @ arg r0 = sound ID (some kind of staff sound?)
  blh m4aSongNumStart

  NoSound:
  pop {r0}
  bx r0

@ this isnt global so im copypasting it lol
RallyAuraCheck:
  ldr r0, =GetUnitsInRange
  mov ip, r0

  ldr r0, =gActiveUnit
  ldr r0, [r0]
  mov r1, #0
  mov r2, #2

  bx  ip @ jump (it will return to wherever this was called)

  .pool
  .align

.ltorg
.align
