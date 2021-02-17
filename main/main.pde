PFont f;
public RigidBody r;
public ArrayList<RigidBody> body_list = new ArrayList<RigidBody>();
float grav = .001;
float timestep = 0;
float x=1, y=-3.6, lim = .001;

boolean start = false, lim_check = false;


void setup(){
  size(3840, 2180);
  f = createFont("Arial",36,true);
  // String, Float, Float,  Boolean, Float, Float
  // Type,   Mass,  Radius, Motion,  X,     Y
  // r = new RigidBody("Planet", random(10), random(100), true, random(width), random(height));
  // r.heading_align(new Vector(random(6) - 3, random(6) - 3));
  
   
   r = new RigidBody("Earth", 10, 20, false, 1200, height/2 - 300);
   r.set_color(color(3, 207, 252));
   r.heading_align(new Vector(x, y));
   body_list.add(r);
   
   /*
   r = new RigidBody("Mars", 20, 35, false, 1200, height/2 + 300);
   r.set_color(color(215, 60, 0));
   r.heading_align(new Vector(x, y));
   body_list.add(r);
   
   r = new RigidBody("Neptune", 50, 50, false, 800, height/2);
   r.set_color(color(50, 72, 168));
   r.heading_align(new Vector(x, y));
   body_list.add(r);
   */
    
   r = new RigidBody("Sun", 100, 157, false);
   r.heading_align(new Vector(0, 3));
   r.set_color(color(255.0, 255.0, 0.0));
   body_list.add(r);
  
  
}


void keyPressed() {
  boolean movement = false;
  switch(keyCode){
    case 38: //Up
      y-=lim;
      movement = true;
      break;
    case 37: //Left
      x-=lim;
      movement = true;
      break;
    case 40: //Down
      y+=lim;
      movement = true;
      break;
    case 39: //Right
      x+=lim;
      movement = true;
      break;
    case 32:
      start = true;
      for(RigidBody r : body_list){
        if(r.type != "Sun"){
          r.motion = true;
        }
      }
      break;
     case 72:
       for(RigidBody r : body_list){
          if(r.type != "Sun"){
            r.show_tracker = !r.show_tracker;
          }
        }
        break;
     
     case 65:
       lim_check = !lim_check;
       if(lim_check){
         lim = 1;
       }else{
         lim = .001;
       }
       
       
  }
  if(movement){
    for(RigidBody r : body_list){
      if(r.type != "Sun"){
        r.heading_align(new Vector(x, y));
      }
    }  
    movement = false;
  }  
  
}

void draw(){
  background(0);
  textFont(f); 
  text(body_list.get(0).type + "  ~~~  " + body_list.get(0).velocity.x + "  ~~~  " + body_list.get(0).velocity.y,width/2,30);
  //text(body_list.get(1).type + "  ~~~  " + body_list.get(1).velocity.x + "  ~~~  " + body_list.get(1).velocity.y,width/2,60);
  //text(body_list.get(2).type + "  ~~~  " + body_list.get(2).velocity.x + "  ~~~  " + body_list.get(2).velocity.y,width/2,90);

  update_bodies();
}

void update_bodies(){
  
   for(RigidBody r : body_list){
     if(r.motion && start){
       r.update();    
     }
     r.show();
    
   }
   if(start){
     timestep++;
   }
  
}
