Credit to [PHC](https://github.com/ZhengyiLuo/PHC)

## Installation
Here we use `uv` to manage the environment, please make sure you have installed `uv` first.

```bash
./install.sh
```

Modifications:
- set OMP_NUM_THREADS to 1 for multiprocessing
- simplified the config for retargeting process

## Data preparation

Under the `data/AMASS` folder, I have downloaded one motion file for instance:
```bash
|-- data
|   |-- AMASS
|       |-- SFU                                 # sub-dataset name
|           |-- 0005                            # subject id
|               |-- 0005_Walking001_poses.npz   # motion file name
|               |-- ...
```
Of course, you can download the other motion files you like from the [AMASS](https://amass.is.tue.mpg.de/) website.

## Fitting motion data from AMASS

First we need to fit the smpl shape to the humanoid robot:
```bash
uv run scripts/1-fit_smpl_shape.py
```
It will save the fitted smpl `beta` parameters and the corresponding `scale` parameters in the `data/g1_29dof/shape_optimized_v1.pkl` folder.

Then we need to fit the motion data to the humanoid robot:
```bash
uv run scripts/2-fit_smpl_motion.py +amass_root=./data/AMASS
```
If you only have one motion file, it will save the fitted motion data in the `data/g1_29dof/v1/singles` folder.
Otherwise, it will save the fitted motion data in the `data/g1_29dof/v1/amass_all.pkl`.

Finally, we can visualize the fitted motion data:
```bash
# for single motion file
uv run scripts/3-vis_q_mj.py +motion_file=./data/g1_29dof/v1/singles/0005_Walking001_poses.pkl

# for multiple motion files
uv run scripts/3-vis_q_mj.py +motion_file=./data/g1_29dof/v1/amass_all.pkl
```