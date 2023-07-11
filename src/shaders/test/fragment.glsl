#define PI 3.1415926535897932384626433832795

precision mediump float;

varying vec2 vUv;

float random (vec2 st) {
    return fract(sin(dot(st.xy, vec2(12.9898,78.233))) * 43758.5453123);
}

vec2 rotate(vec2 uv, float rotation, vec2 mid) {
    return vec2 (
      cos(rotation) * (uv.x - mid.x) + sin(rotation) * (uv.y - mid.y) + mid.x,
      cos(rotation) * (uv.y - mid.y) - sin(rotation) * (uv.x - mid.x) + mid.y
    );
}

//	Classic Perlin 2D Noise 
//	by Stefan Gustavson

vec2 fade(vec2 t) {
    return t*t*t*(t*(t*6.0-15.0)+10.0);
}

vec4 permute(vec4 x) {return mod(((x*34.0)+1.0)*x, 289.0);}

float cnoise(vec2 P) {
    vec4 Pi = floor(P.xyxy) + vec4(0.0, 0.0, 1.0, 1.0);
    vec4 Pf = fract(P.xyxy) - vec4(0.0, 0.0, 1.0, 1.0);
    Pi = mod(Pi, 289.0); // To avoid truncation effects in permutation
    vec4 ix = Pi.xzxz;
    vec4 iy = Pi.yyww;
    vec4 fx = Pf.xzxz;
    vec4 fy = Pf.yyww;
    vec4 i = permute(permute(ix) + iy);
    vec4 gx = 2.0 * fract(i * 0.0243902439) - 1.0; // 1/41 = 0.024...
    vec4 gy = abs(gx) - 0.5;
    vec4 tx = floor(gx + 0.5);
    gx = gx - tx;
    vec2 g00 = vec2(gx.x,gy.x);
    vec2 g10 = vec2(gx.y,gy.y);
    vec2 g01 = vec2(gx.z,gy.z);
    vec2 g11 = vec2(gx.w,gy.w);
    vec4 norm = 1.79284291400159 - 0.85373472095314 * vec4(dot(g00, g00), dot(g01, g01), dot(g10, g10), dot(g11, g11));
    g00 *= norm.x;
    g01 *= norm.y;
    g10 *= norm.z;
    g11 *= norm.w;
    float n00 = dot(g00, vec2(fx.x, fy.x));
    float n10 = dot(g10, vec2(fx.y, fy.y));
    float n01 = dot(g01, vec2(fx.z, fy.z));
    float n11 = dot(g11, vec2(fx.w, fy.w));
    vec2 fade_xy = fade(Pf.xy);
    vec2 n_x = mix(vec2(n00, n01), vec2(n10, n11), fade_xy.x);
    float n_xy = mix(n_x.x, n_x.y, fade_xy.y);
    return 2.3 * n_xy;
}

void main() {

    //Greysale gradient
    // float strength = 1.0 - vUv.y;

    //Greyscale gradient faster
    // float strength = vUv.y * 10.0;

    //Saw gradients
    // float strength = mod(vUv.y * 10.0, 1.0);

    //Saw gradients constant
    // float strength = mod(vUv.y * 10.0 , 1.0);
    // strength = step(0.5, strength);

    //Saw gradients constant thin
    // float strength = mod(vUv.x * 10.0 , 1.0);
    // strength = step(0.8, strength);

    //Grid
    // float strength = step(0.8, mod(vUv.x * 10.0 , 1.0));
    // strength += step(0.8, mod(vUv.y * 10.0 , 1.0));

    //Dots Grid
    // float strength = step(0.8, mod(vUv.x * 10.0 , 1.0));
    // strength *= step(0.8, mod(vUv.y * 10.0 , 1.0));

    //Rectanle Grid
    // float strength = step(0.4, mod(vUv.x * 10.0 , 1.0));
    // strength *= step(0.8, mod(vUv.y * 10.0 , 1.0));

    //Right Angle Grid
    // float barsX = step(0.4, mod(vUv.x * 10.0 , 1.0));
    // barsX *= step(0.8, mod(vUv.y * 10.0 , 1.0));

    // float barsY = step(0.4, mod(vUv.y * 10.0 , 1.0));
    // barsY *= step(0.8, mod(vUv.x * 10.0 , 1.0));

    // float strength = barsX + barsY;

    //Crosses
    // float barsX = step(0.4, mod(vUv.x * 10.0 , 1.0));
    // barsX *= step(0.8, mod(vUv.y * 10.0 + 0.2 , 1.0));

    // float barsY = step(0.8, mod(vUv.x * 10.0 + 0.2 , 1.0));
    // barsY *= step(0.4, mod(vUv.y * 10.0 , 1.0));

    // float strength = barsX + barsY;

    //Gradient from the middle
    // float strength = abs(vUv.x - 0.5);

    //Gradient cross
    // float strength = min(abs(vUv.x - 0.5), abs(vUv.y - 0.5));

    //Gradient hole
    // float strength = max(abs(vUv.x - 0.5), abs(vUv.y - 0.5));

    //Square with hole
    // float base = step(0.2 , max(abs(vUv.x - 0.5), abs(vUv.y - 0.5)));
    // float cutout = step(0.25 , max(abs(vUv.x - 0.5), abs(vUv.y - 0.5)));

    // float strength = base - cutout;

    //Grescale levels
    // float strength = floor(vUv.x * 10.0) / 10.0;

    //Grescale level grid
    // float levelsX = floor(vUv.x * 10.0) / 10.0;
    // float levelsY = floor(vUv.y * 10.0) / 10.0;

    // float strength = levelsY * levelsX;

    //Noise Texture
    // float strength = random(vUv);

    //Block random noise
    // float levelsX = floor(vUv.x * 10.0) / 10.0;
    // float levelsY = floor(vUv.y * 10.0) / 10.0;

    // float strength = random(vec2(levelsY, levelsX));

    //Sqeeved block noise
    // vec2 gridUv = vec2(
    //     floor(vUv.x * 10.0) / 10.0,
    //     floor((vUv.y + vUv.x) * 10.0) / 10.0
    // );

    // float strength = random(gridUv);


    //Circular Gradient starting from left bottom corner
    // float strength = length(vUv);

    //Circlular gradient from middle
    // float strength = length(vUv - 0.5);
    // float strength = distance(vUv, vec2(0.5));

    //Circ Gradient inverted
    // float strength = 1.0 - length(vUv - 0.5);

    //Star gradient
    // float strength = 0.015 / distance(vUv, vec2(0.5));

    //Star gradient squashed
    // vec2 lightUv = vec2(
    //     vUv.x * 0.1 + 0.45,
    //     vUv.y * 0.5 + 0.25
    // );
    // float strength = 0.015 / distance(lightUv, vec2(0.5));

    //Star actual
    // float starX = 0.015 / distance(vec2(vUv.x * 0.1 + 0.45, vUv.y), vec2(0.5));
    // float starY = 0.015 / distance(vec2(vUv.x, vUv.y * 0.1 + 0.45), vec2(0.5));

    // float strength = starX * starY;

    //Star actual rotated
    // vec2 rotatedUv = rotate(vUv, PI * 0.25, vec2(0.5));

    // float starX = 0.015 / distance(vec2(rotatedUv.x * 0.1 + 0.45, rotatedUv.y), vec2(0.5));
    // float starY = 0.015 / distance(vec2(rotatedUv.x, rotatedUv.y * 0.1 + 0.45), vec2(0.5));

    // float strength = starX * starY;

    //Circle Hole
    // float strength = step(0.8, distance(vUv, vec2(0.5)) * 3.0);

    //Gradient Donut
    // float strength = abs(distance(vUv, vec2(0.5)) - 0.25);

    //Hard circle
    // float strength = step(0.01, abs(distance(vUv, vec2(0.5)) - 0.25));

    //Waved UV
    // vec2 wavedUv = vec2(
    //     vUv.x,
    //     vUv.y + sin(vUv.x * 30.0) * 0.1
    // );
    // float strength = 1.0 - step(0.01, abs(distance(wavedUv, vec2(0.5)) - 0.25));

    //Waved UV both axis
    // vec2 wavedUv = vec2(
    //     vUv.x + sin(vUv.y * 30.0) * 0.1,
    //     vUv.y + sin(vUv.x * 30.0) * 0.1
    // );
    // float strength = 1.0 - step(0.01, abs(distance(wavedUv, vec2(0.5)) - 0.25));

    //Virus
    // vec2 wavedUv = vec2(
    //     vUv.x + sin(vUv.y * 100.0) * 0.1,
    //     vUv.y + sin(vUv.x * 100.0) * 0.1
    // );
    // float strength = 1.0 - step(0.01, abs(distance(wavedUv, vec2(0.5)) - 0.25));

    //Angle Gradient
    // float strength = atan(vUv.x, vUv.y);

    //Angle Gradient from middle
    // float strength = atan(vUv.x - 0.5, vUv.y - 0.5);

    //Angle Gradient from middle full
    // float angle = atan(vUv.x - 0.5, vUv.y - 0.5);
    // angle /= PI * 2.0;
    // float strength = angle + 0.5;

    //Angle Gradient Fan
    // float angle = atan(vUv.x - 0.5, vUv.y - 0.5);
    // angle /= PI * 2.0;
    // float strength = mod((angle + 0.5) * 20.0, 1.0);

    //Angle Gradient Indvidual fans
    // float angle = atan(vUv.x - 0.5, vUv.y - 0.5);
    // angle /= PI * 2.0;
    // float strength = sin(angle * 100.0);

    //Spiky circle
    // float angle = atan(vUv.x - 0.5, vUv.y - 0.5);
    // angle /= PI * 2.0;
    // float sinusAngle = sin(angle * 100.0);

    // float radius = 0.25 + sinusAngle * 0.01;
    // float strength = 1.0 - step(0.015, abs(distance(vUv, vec2(0.5)) - radius));

    //Perlin Noise
    // float strength = cnoise(vUv* 10.0);

    //Perlin Noise Clamped
    // float strength = step(0.01, cnoise(vUv * 10.0));

    //Perlin Noise Worm lines
    // float strength = 1.0 - abs(cnoise(vUv * 10.0));

    //Perlin based elevation/mountains
    // float strength = floor(abs(cnoise(vUv * 5.0)) * 10.0) / 10.0;

    //Perlin based trans vornoi combo
    // float strength = sin(cnoise(vUv * 10.0) * 15.0);

    //Perlin based trans vornoi combo sharp
    // float strength = step(0.8, sin(cnoise(vUv * 10.0) * 15.0));

    // gl_FragColor = vec4(strength, strength, strength , 1.0);

    //Colors!!!

    float factor = step(0.8, sin(cnoise(vUv * 10.0) * 15.0));
    vec3 backgroundColor = vec3(0.0);
    vec3 uvColor = vec3(vUv, 1.0);

    vec3 mixColor = mix(backgroundColor, uvColor, factor);

    gl_FragColor = vec4(mixColor, 1.0);

}