#define PI 3.1415926535897932384626433832795

precision mediump float;

varying vec2 vUv;
varying float vFactor;

void main() {

    float factor = floor(vFactor * 10.0) / 10.0;
    vec4 baseColor = vec4(0.29, 0.15, 0.01, 1.0);
    vec4 highlightColor = vec4(1.00, 0.61, 0.18, 1.0);

    vec4 baseColorMix = mix(baseColor, highlightColor, factor);

    float slopesFactor = step(0.1 , mod(vFactor * 4.0, 1.0));
    vec4 slopesColor = vec4(2.00, 1.71, 0.33, 1.0);

    vec4 finalColorMix = mix(baseColorMix, slopesColor , slopesFactor);

    gl_FragColor = finalColorMix;
}