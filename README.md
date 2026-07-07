# Thin-Filament Model with NEM-S1

MATLAB code accompanying:

> **Strong binding myosin cross-bridges dynamically modulate thin filament near-neighbor cooperative interactions in murine myocardium.**
> Tuan A. Phan and Daniel P. Fitzsimons.

The code implements the ordinary-differential-equation (ODE) thin-filament model used in the paper and reproduces the model figures. The model extends our previous four-state model ([Phan & Fitzsimons, 2025](https://rupress.org/jgp/article/157/2/e202413582/277237/Modeling-the-effects-of-thin-filament-near?searchresult=1)) with NEM-S1 treatment (two additional NEM-S1-bound regulatory-unit states) and near-neighbor RU–RU, XB–RU, and XB–XB cooperative interactions.

## Requirements

- MATLAB (R2021b or later recommended)
- Optimization Toolbox and Global Optimization Toolbox (`patternsearch` with a Latin-Hypercube search is used)
- ODE solvers `ode15s` / `ode23` are part of base MATLAB (no toolbox needed to reproduce the figures)

## Repository layout

The code is organized by parameter set (as defined in the manuscript):

- `Parameter Set 2/` — RU–RU unitary interaction (Table 3, Figure 3)
- `Parameter Set 8/` — RU–RU, XB–XB, and XB–RU ensemble interactions (Table 3, Figures 4, 6, 7)

Each folder contains the same core files:

| File | Purpose |
|------|---------|
| `filament_function_NEM_S1.m` | Right-hand side of the ODE system (the thin-filament model with NEM-S1 and near-neighbor cooperativity). |
| `rate_force_redev_NEM.m` | Computes the rate of force redevelopment (*k*tr) vs. pCa via the slack–restretch maneuver. |
| `rel_rate_force_redev_NEM.m` | Computes relative *k*tr vs. pCa. |
| `rel_force_NEM.m` | Computes relative steady-state force (P/P₀) vs. pCa. |
| `force_redevelop_NEM.m` | ODE event function used to time force redevelopment. |
| `main_fit_NEM_*.m` | Driver script that fits the 21 model parameters to the mechanical data (toggle the `Fit_*` flags at the top to run a given fit). |
| `fitted_murine_ctrl_*.mat`, `fitted_murine_NEM_*.mat` | Saved fitted parameters and data for control and NEM-S1 murine myocardium. |
| `figure*.m` | Scripts that load the `.mat` files and reproduce the corresponding manuscript figures. |
| `rate_force_redev_NEM_1.m` (Set 8) | Variant used to sweep *u₂* and *z₂* for the Figure 7 landscapes. |

## Model parameters

The 21-parameter vector `p` used by `filament_function_NEM_S1.m` is:

```
p = [k_BC^0, k_BC^Ca, k_CB^0, k_CB^Ca, f_CM1^0, f_M1C^0, k_M1M2, k_M2M1, k_M2C,
     Ca/Ca50, alpha, alpha_bar, beta, beta_bar, u1, u2, z1, z2, v, w, NEM]
```

State variables: `C` (closed), `M1` (strongly bound, non-force-generating), `M1_bar` and the fixed fraction `NEM` (M₁⁰) for NEM-S1-bound RUs, and `M2` (strongly bound, force-generating); the blocked state `B` follows by conservation.

## Reproducing the figures

1. Open MATLAB and `cd` into the relevant parameter-set folder (the figure scripts load the `.mat` files from the current folder).
2. Run the figure script, e.g.:

   ```matlab
   cd 'Parameter Set 8'
   figure4A     % k_tr vs pCa, control vs NEM-S1 (ensemble set)
   figure6      % effect of independently varying u2 or z2
   figure7      % u2–z2 cooperative landscape
   ```

3. To re-fit the parameters instead of using the saved fits, open `main_fit_NEM_*.m`, set the desired `Fit_*` flag to `1`, and run the script.

## Data

The underlying mechanical data (steady-state force, *k*tr, and relative *k*tr vs. pCa for control and NEM-S1 murine left ventricle) are given in Supplemental Tables S1 and S2 of the manuscript and are embedded in the `main_fit_NEM_*.m` scripts and the `.mat` files.
