

class RigidBody{
  
  public String type = "Planet";
  public float mass = 0.0;
  public float radius = 10;
  public boolean motion = true;
  public float x, y;
  
  public boolean show_tracker = true;
  
  public color c;
  
  public Vector velocity = new Vector(0, 0);

  public RigidBody(Object... args){
    ArrayList<String> args_list = new ArrayList<String>();

     for(Object o : args){
       args_list.add(o.toString());
     }
     
     x = width/2 + this.radius * 3;
     y = height/2 + this.radius * 3;

     switch(args_list.size()){  
       case 6:
          this.y = Float.parseFloat(args_list.get(5));
       case 5:
          this.x = Float.parseFloat(args_list.get(4));
       case 4:
          this.motion =  Boolean.parseBoolean(args_list.get(3));
       case 3:
          this.radius = Float.parseFloat(args_list.get(2));
       case 2:
          this.mass = Float.parseFloat(args_list.get(1));
       case 1:
          this.type = args_list.get(0);
       default:
         break;
     }
     
      
   }
   
   public void heading_align(Vector v){
     this.velocity = v;
   }
   
   public void set_color(color c){
     this.c = c;
   }
   
   public void print_core_attr(){
     println(this.type);
     println(this.mass);
     println(this.radius);
     println(this.motion);
     println(this.x);
     println(this.y);
   }
     
    
     
   public void show(){
     fill(c);
     ellipse(this.x, this.y, this.radius, this.radius);
     if(this.type != "Sun" && this.show_tracker){
       show_time_steps();
     }
   }
   
   public void collision(){
     
     for(RigidBody p : body_list){
       if(p != this){
         double dist = Math.sqrt(Math.pow(this.x - p.x, 2) + Math.pow(this.y - p.y, 2));
         if(dist < this.radius + p.radius){
           this.motion = false;
           p.motion = false;
         }
       }
     }
   }
   
   public void update(){

        for(RigidBody p : body_list){
            if(p != this){   
                Vector t = new Vector(this.x, this.y);
                float sqrDist = t.dist(p);
                Vector forceDir = t.two_point_uv_update(p);
                Vector force = forceDir.mult_components(grav * this.mass * p.mass);
                force = force.div_components(sqrDist);
                Vector acceleration  = force.div_components(this.mass);
                this.velocity = this.velocity.add_vector(acceleration.mult_components(timestep));
            }
        }
        
        
        
        this.x += this.velocity.x;
        this.y += this.velocity.y;
    }
    
    public ArrayList<RigidBody> d = new ArrayList<RigidBody>();
    public void show_time_steps(){
      d = new ArrayList<RigidBody>();
      
      float dx = this.x;
      float dy = this.y;
      Vector velocity = this.velocity;
      
      for(int i = 1; i < 2000; i++){
        for(RigidBody p : body_list){
          
              if(p != this){   
                  Vector t = new Vector(dx, dy);
                  float sqrDist = t.dist(p);
                  Vector forceDir = t.two_point_uv_update(p);
                  Vector force = forceDir.mult_components(grav * this.mass * p.mass);
                  force = force.div_components(sqrDist);
                  Vector acceleration  = force.div_components(this.mass);
                  velocity = velocity.add_vector(acceleration.mult_components(timestep + i));
              }
          }
        
        dx += velocity.x;
        dy += velocity.y;
        
        d.add(new RigidBody("Dot", 1, 4, false, dx, dy));
      }
      
      int count = d.size();
      for(RigidBody ind : d){
         fill(color(255, 255, 255, 100 * (count/d.size())));
         ellipse(ind.x - 10, ind.y - 10, ind.radius, ind.radius);
      }
      count --;
    }
 
}
