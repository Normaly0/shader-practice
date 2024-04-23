uniform mat4 viewMatrix;
uniform mat4 modelMatrix;
uniform mat4 projectionMatrix;

attribute vec2 uv;
attribute vec3 position;

varying vec2 vUv;

void main() {

    gl_Position = projectionMatrix * viewMatrix * modelMatrix * vec4(position, 1.0);

    vUv = uv;

}