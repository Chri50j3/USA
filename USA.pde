// 1.) Hent data fra csv filen
// 2.) Visualiser data i et grafisk diagram.
// 3.) Lav eventuelt en loading skærm vha. thread's

Table data;
float allArea;
boolean loadDone = false;

void setup(){
  size(1920,1080);
  thread("loadScrean");
  thread("load");
}

void draw(){
  bakePie();
}

void bakePie(){
  if(loadDone){
    float prev_d = 0;
      background(200);
      for(TableRow r: data.rows()){  
        //cirkel
        fill(255);
        arc(width/2,height/2,height/2,height/2,prev_d,radians((r.getInt("area (sq. mi)")/allArea)*360)+prev_d,PIE);
        prev_d+=radians((r.getInt("area (sq. mi)")/allArea)*360);
    }
  }
}

void loadScrean(){
  while(loadDone == false){
      clear();
      for(int i = -1;i<3;i++){
        circle(width/2+i*50,height/2,25); 
      }
  }
}

void load(){
  data = loadTable("https://raw.githubusercontent.com/jakevdp/data-USstates/master/state-areas.csv", "header");
  for(TableRow r: data.rows()){ 
  allArea += r.getInt("area (sq. mi)");
  }
  loadDone = true;
}
