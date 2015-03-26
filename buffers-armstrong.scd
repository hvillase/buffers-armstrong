// =====================================
// Grabación de Buffers para improvisar
// =====================================
s.boot;

// Buffers graban 5 segundos
// Para hacerlos mas grandes multiplica el s.sampleRate por los segundos que quieras
(
~buf1=Buffer.alloc(s, s.sampleRate * 5.0, 1);
~buf2=Buffer.alloc(s, s.sampleRate * 5.0, 1);
);

// Sintes
(
// odb=1, es lo que permite sobreescribir la señal del buffer
(
SynthDef(\r1,{|in=0,odb=1|
	RecordBuf.ar(SoundIn.ar(in),~buf1.bufnum,0,1,odb,loop:0,doneAction:2);
}).add;
);
// odb=0, es lo que perminte reemplazar la señal del buffer
(
SynthDef(\r2,{|in=0,odb=0|
	RecordBuf.ar(SoundIn.ar(in),~buf2.bufnum,0,1,odb,loop:0,doneAction:2);
}).add;
);
)

Synth(\r1); // sobreescribe el sonido
Synth(\r2); // reemplaza el sonido

// Rutina 1
Ndef(\play1).play; // activa el nodo
Ndef(\play1,{|rate=1,pan=0,amp=1|Pan2.ar(PlayBuf.ar(1,~buf1.bufnum,rate,Dust.kr(1/5),~buf1.numFrames/~buf1.numFrames),pan,amp)});
Ndef(\play1).release; // para el sonido momentaneamente, .send lo reactiva

// Rutina 2
Ndef(\play2).play; // activa el nodo
Ndef(\play2,{|rate=0.5,pan=0|Pan2.ar(PlayBuf.ar(1,~buf2.bufnum,rate,Impulse.kr(1/5),~buf2.numFrames/~buf2.numFrames),pan)});
Ndef(\play2).release; // para el sonido momentaneamente, .send lo reactiva

// cambios que puedes realizar
// Impulse.kr en lugar de Dust.kr y viceversa
// el valor de Impulse y Dust es de 1/5, lo que ocasiona que cad 5 segundos haya un cambio, pudes incrementar el valor para hacer mas "granular" el sonido
// el valor que divide a ~buf1.numFrames los pues sustituir por 2,4,6,8,16; 1 deja de sonar, o que tal por un MouseX o Y


