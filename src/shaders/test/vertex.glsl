uniform mat4 modelMatrix;
uniform mat4 viewMatrix;
uniform mat4 projectionMatrix;

uniform float uTime;

attribute vec3 position;
attribute vec2 uv;

varying vec2 vUv;
varying float vTime;


void main() {
    
    gl_Position = projectionMatrix * viewMatrix * modelMatrix * vec4(position, 1.0);

    vUv = uv;
    vTime = uTime;

}