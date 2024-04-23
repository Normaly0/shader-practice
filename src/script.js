import * as THREE from 'three'
import { OrbitControls } from 'three/examples/jsm/controls/OrbitControls.js'

import { EffectComposer } from 'three/examples/jsm/postprocessing/EffectComposer'
import { RenderPass } from 'three/examples/jsm/postprocessing/RenderPass'
import { UnrealBloomPass } from 'three/examples/jsm/postprocessing/UnrealBloomPass'

import * as dat from 'lil-gui'

import testVertexShader from './shaders/test/vertex.glsl'
import testFragmentShader from './shaders/test/fragment.glsl'

import terrainVertexShader from './shaders/terrain/vertex.glsl'
import terrainFragmentShader from './shaders/terrain/fragment.glsl'

import improvVertexShader from './shaders/improvise/vertex.glsl';
import improvFragmentShader from './shaders/improvise/fragment.glsl';

/**
 * Base
 */
// Debug
const gui = new dat.GUI();

// Canvas
const canvas = document.querySelector('canvas.webgl')

// Scene
const scene = new THREE.Scene()

/**
 * Test mesh
 */
// Geometry
const geometry = new THREE.PlaneGeometry(1, 1, 128, 128)

// Material
const material = new THREE.RawShaderMaterial({
    vertexShader: testVertexShader,
    fragmentShader: testFragmentShader,
    uniforms: {
        uTime: {value: 0}
    },
    side: THREE.DoubleSide
})

// const material = new THREE.RawShaderMaterial({
//     vertexShader: terrainVertexShader,
//     fragmentShader: terrainFragmentShader,
//     uniforms: {
//         uTime: {value: 0}
//     },
//     side: THREE.DoubleSide,
// })

// const material = new THREE.RawShaderMaterial({
//     vertexShader: improvVertexShader,
//     fragmentShader: improvFragmentShader,
//     uniforms: {
//         uTime: {value: 0}
//     },
//     side: THREE.DoubleSide
// })



// Mesh
const mesh = new THREE.Mesh(geometry, material)
scene.add(mesh)

/**
 * Sizes
 */
const sizes = {
    width: window.innerWidth,
    height: window.innerHeight
}

window.addEventListener('resize', () =>
{
    // Update sizes
    sizes.width = window.innerWidth
    sizes.height = window.innerHeight

    // Update camera
    camera.aspect = sizes.width / sizes.height
    camera.updateProjectionMatrix()

    // Update renderer
    renderer.setSize(sizes.width, sizes.height)
    renderer.setPixelRatio(Math.min(window.devicePixelRatio, 2))
})

/**
 * Camera
 */
// Base camera
const camera = new THREE.PerspectiveCamera(75, sizes.width / sizes.height, 0.1, 100)
camera.position.set(0.25, - 0.25, 1)
scene.add(camera)

// Controls
const controls = new OrbitControls(camera, canvas)
controls.enableDamping = true

/**
 * Renderer
 */
const renderer = new THREE.WebGLRenderer({
    canvas: canvas
})
renderer.setSize(sizes.width, sizes.height)
renderer.setPixelRatio(Math.min(window.devicePixelRatio, 2))

const effectComposer = new EffectComposer(renderer);
effectComposer.setPixelRatio(Math.min(window.devicePixelRatio, 2));
effectComposer.setSize(sizes.width, sizes.height);

const renderPass = new RenderPass(scene, camera);
effectComposer.addPass(renderPass);

const unrealBloomPass = new UnrealBloomPass();
unrealBloomPass.strength = 0.3;
unrealBloomPass.threshold = 1.5;
unrealBloomPass.radius = 0.2;
// effectComposer.addPass(unrealBloomPass);

// const renderPass = new renderPass

/**
 * Animate
 */

const clock = new THREE.Clock();

const tick = () =>
{
    const elapsedTime = clock.getElapsedTime();

    //Update Material
    material.uniforms.uTime.value = elapsedTime;

    // Update controls
    controls.update()

    // Render
    // renderer.render(scene, camera)
    effectComposer.render();

    // Call tick again on the next frame
    window.requestAnimationFrame(tick)
}

tick()