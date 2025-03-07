rtsetparams(44100, 2, 512)
load("WAVETABLE")
bus_config("WAVETABLE", "out 0-1")
control_rate(1000)

start = 0
ii = 0
freq = {}
start2=0

while (ii < 10) {
    freq[ii] = trand(220, 660) 
    ii = ii + 1
}


table_types = {"wave", "random", "curve", "line"}
wave_types = {"sawdown", "saw", "buzz", "square", "triangle"}

print(freq)

ii = 0
while (ii < 50) {
    dur = irand(0.1, 0.7)
	dur2=irand(0.1,0.4)
    table_index = trand(0, 3)  
    table_type = table_types[table_index]  

    wave_index = trand(0, 4)  
    wave_type = wave_types[wave_index]
	
   
    if (table_type == "wave") {
        wtable = maketable(table_type, 1000, wave_type)
    }
    else if (table_type == "random") {
        wtable = maketable(table_type, 1000, "gaussian", 1, 100)  
    }
    else if (table_type == "curve") {
       wtable = maketable("curve", 1000, 0, 0, 0.5, 1, 1, -0.5, 2, 0)
    }
    else if (table_type == "line") {
        wtable = maketable(table_type, 1000, 0, 0, 1, 1, 2, 0)  
    }


	if (ii % 4 == 0) {
        vibenv = maketable("wave3", "nonorm", 1000, irand(2, 5), irand(0, 1), 0)
        //pan = 0
    }
    else if (ii % 4 == 1) {
        vibenv = maketable("curve", 1000, 0, 1,  0.5,  1, irand(50, 80) * 0.01,  
                            0.5, 2, 1,  0.5,  3, 1,  0.5, 4, 0.5, 0.5, 5, 5)
		//pan=0.5
    }
    else if(ii%4==3){
        vibenv = maketable("random", "nonorm", 1000, "cauchy",-1,1)
		//pan=1
    }
	else{
		vibenv=1
		//pan=0.5
	}

	if(ii%2==0)
		pan=1
	else
		pan=0
    k = trand(0, 9) 
	
    WAVETABLE(start, dur, 20000, freq[k]*vibenv, 0.5, wtable)
	WAVETABLE(start2,dur2,20000,freq[k]*vibenv,pan,wtable)

    ii = ii + 1
    start = start + dur
	start2=start2+dur
}
i=0
freq2={}
while (i < 10) {
    freq2[i] = trand(220, 660)  
    i = i + 1
}

ii = 0
while (ii < 50) {
    dur = irand(0.1, 0.5)
	
    table_index = trand(0, 3)  
    table_type = table_types[table_index]  

    wave_index = trand(0, 4)  
    wave_type = wave_types[wave_index]
	
    
    if (table_type == "wave") {
        wtable = maketable(table_type, 1000, wave_type)
    }
    else if (table_type == "random") {
        wtable = maketable(table_type, 1000, "gaussian", 1, 100)  
    }
    else if (table_type == "curve") {
       wtable = maketable("curve", 1000, 0, 0, 0.5, 1, 1, -0.5, 2, 0)
    }
    else if (table_type == "line") {
        wtable = maketable(table_type, 1000, 0, 0, 1, 1, 2, 0)  
    }


	if (ii % 4 == 0) {
        vibenv = maketable("wave3", "nonorm", 1000, irand(2, 5), irand(0, 1), 0)
        pan = 0
    }
    else if (ii % 4 == 1) {
        vibenv = maketable("curve", 1000, 0, 1,  0.5,  1, irand(50, 80) * 0.01,  
                            0.5, 2, 1,  0.5,  3, 1,  0.5, 4, 0.5, 0.5, 5, 5)
		pan=0.5
    }
    else if(ii%4==3){
        vibenv = maketable("random", "nonorm", 1000, "cauchy",-1,1)
		pan=1
    }
	else{
		vibenv=1
		pan=0.5
	}
	
    k = trand(0, 9) 

    WAVETABLE(start, dur, 20000, freq2[k]*vibenv, pan, wtable)

    print("Table:", table_type, "Waveform:", wave_type, "Freq:", freq[k], "Duration:", dur)

    ii = ii + 1
    start = start + dur
}