class Vector{
    public float x, y;
    public Vector(float x, float y){
        this.x = x;
        this.y = y;
    }

    public float sqrMagnitude(){
        return (float) Math.sqrt(Math.pow(this.x, 2) + Math.pow(this.y, 2));
    }

    public float dist(RigidBody planet){
        return (float) Math.sqrt(Math.pow(this.x - planet.x, 2) + Math.pow(this.y - planet.y, 2));
    }
    
    public Vector two_point_uv_update(RigidBody planet){
        double denom = Math.sqrt(Math.pow(this.x - planet.x, 2) + Math.pow(this.y - planet.y, 2));
        float x_ = (float)(-(this.x - planet.x) / denom);
        float y_ = (float)(-(this.y - planet.y) / denom);
        Vector v = new Vector(x_, y_);
        return v;
    }

    public Vector mult_components(float a){
        return new Vector(this.x * a, this.y * a);
    }

    public Vector div_components(float a){
        return new Vector(this.x / a, this.y / a);
    }

    public Vector add_vector(Vector v){
        return new Vector(this.x + v.x, this.y + v.y);
    }

}
