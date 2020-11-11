module TestExamples2D  # TODO: Taal remove

using Test
using Trixi

include("test_trixi.jl")

# Start with a clean environment: remove Trixi output directory if it exists
outdir = "out"
isdir(outdir) && rm(outdir, recursive=true)

# pathof(Trixi) returns /path/to/Trixi/src/Trixi.jl, dirname gives the parent directory
const EXAMPLES_DIR = joinpath(pathof(Trixi) |> dirname |> dirname, "examples", "2d")

# Run basic tests
@testset "Examples 2D" begin
  @testset "taal-confirmed parameters_advection_basic.toml" begin
    test_trixi_run(joinpath(EXAMPLES_DIR, "parameters_advection_basic.toml"),
            l2   = [9.144681765639205e-6],
            linf = [6.437440532547356e-5])
  end
  @testset "taal-confirmed parameters_advection_basic.toml with polydeg=1" begin
    test_trixi_run(joinpath(EXAMPLES_DIR, "parameters_advection_basic.toml"),
            l2   = [0.05264106093598111],
            linf = [0.08754218386076518],
            polydeg=1)
  end
  @testset "taal-confirmed parameters_advection_basic.toml with carpenter_kennedy_erk43" begin
    test_trixi_run(joinpath(EXAMPLES_DIR, "parameters_advection_basic.toml"),
            l2   = [8.908962577028364e-6],
            linf = [6.969419032576418e-5],
            time_integration_scheme = "timestep_carpenter_kennedy_erk43_2N!",
            cfl = 0.5)
  end
  @testset "taal-confirmed parameters_advection_basic.toml with parsani_ketcheson_deconinck_erk94" begin
    test_trixi_run(joinpath(EXAMPLES_DIR, "parameters_advection_basic.toml"),
            l2   = [7.932405161658336e-6],
            linf = [6.509399993848142e-5],
            time_integration_scheme = "timestep_parsani_ketcheson_deconinck_erk94_3Sstar!")
  end
  @testset "taal-confirmed parameters_advection_basic.toml with parsani_ketcheson_deconinck_erk32" begin
    test_trixi_run(joinpath(EXAMPLES_DIR, "parameters_advection_basic.toml"),
            l2   = [0.00440542760645958],
            linf = [0.012549162970726613],
            time_integration_scheme = "timestep_parsani_ketcheson_deconinck_erk32_3Sstar!")
  end
  @testset "taal-confirmed parameters_mhd_alfven_wave.toml" begin
    test_trixi_run(joinpath(EXAMPLES_DIR, "parameters_mhd_alfven_wave.toml"),
            l2   = [0.00011134513490658689, 5.880188909157728e-6, 5.880188909159547e-6, 8.432880997656317e-6, 1.2942387343501909e-6, 1.2238820298971968e-6, 1.2238820298896402e-6, 1.830621754702352e-6, 8.071881352562945e-7],
            linf = [0.00025632790161078667, 1.6379021163651086e-5, 1.637902116437273e-5, 2.58759953227633e-5, 5.327732286231068e-6, 8.118520269495555e-6, 8.118520269606577e-6, 1.2107354757678879e-5, 4.165806320060789e-6])
  end
  @testset "taal-confirmed parameters_advection_amr.toml" begin
    test_trixi_run(joinpath(EXAMPLES_DIR, "parameters_advection_amr.toml"),
            l2   = [0.010844189678803203],
            linf = [0.0491178481591637])
  end
  @testset "taal-confirmed parameters_advection_amr_nonperiodic.toml" begin
    test_trixi_run(joinpath(EXAMPLES_DIR, "parameters_advection_amr_nonperiodic.toml"),
            l2   = [0.008016815805080098],
            linf = [0.04229543866599861])
  end
  @testset "taal-confirmed parameters_euler_vortex_amr.toml" begin
    test_trixi_run(joinpath(EXAMPLES_DIR, "parameters_euler_vortex_amr.toml"),
            l2   = [2.0750351586876505e-6, 0.003281637561081054, 0.0032807189382436106, 0.0046470466205649425],
            linf = [4.625172721961501e-5, 0.0318570623352572, 0.031910329823320094, 0.04575283708569344])
  end
  @testset "taal-confirmed parameters_euler_blast_wave_shockcapturing.toml" begin
    test_trixi_run(joinpath(EXAMPLES_DIR, "parameters_euler_blast_wave_shockcapturing.toml"),
            l2   = [0.13910202327088322, 0.11538722576277083, 0.1153873048510009, 0.3387876385945495],
            linf = [1.454418325889352, 1.3236875559310013, 1.323687555933169, 1.8225476335086368],
            n_steps_max=30)
  end
  @testset "taal-confirmed parameters_euler_ec.toml" begin
    test_trixi_run(joinpath(EXAMPLES_DIR, "parameters_euler_ec.toml"),
            l2   = [0.06159341742582756, 0.05012484425381723, 0.05013298724507752, 0.22537740506116724],
            linf = [0.29912627861573327, 0.30886767304359375, 0.3088108573487326, 1.0657556075017878])
  end
  @testset "taal-confirmed parameters_euler_density_wave.toml" begin
    test_trixi_run(joinpath(EXAMPLES_DIR, "parameters_euler_density_wave.toml"),
            l2   = [0.001060077845747576, 0.00010600778457107525, 0.00021201556914875742, 2.6501946139091318e-5],
            linf = [0.0065356386867677085, 0.0006535638688170142, 0.0013071277374487877, 0.0001633909674296774],
            extra_analysis_quantities=["l2_error_primitive", "linf_error_primitive"], t_end=0.5)
  end
  @testset "taal-confirmed parameters_mhd_ec.toml" begin
    test_trixi_run(joinpath(EXAMPLES_DIR, "parameters_mhd_ec.toml"),
            l2   = [0.03607862694368351, 0.04281395008247395, 0.04280207686965749, 0.025746770192645763, 0.1611518499414067, 0.017455917249117023, 0.017456981264942977, 0.02688321120361229, 0.00015024027267648003],
            linf = [0.23502083666166018, 0.3156846367743936, 0.31227895161037256, 0.2118146956106238, 0.9743049414302711, 0.09050624115026618, 0.09131633488909774, 0.15693063355520998, 0.0038394720095667593])
  end
  @testset "taal-confirmed parameters_hyp_diff_harmonic_nonperiodic.toml" begin
    test_trixi_run(joinpath(EXAMPLES_DIR, "parameters_hyp_diff_harmonic_nonperiodic.toml"),
            l2   = [8.618132353932638e-8, 5.619399844708813e-7, 5.619399845476024e-7],
            linf = [1.124861862326869e-6, 8.622436471483752e-6, 8.622436469707395e-6])
  end
  @testset "taal-confirmed parameters_hyp_diff_llf.toml" begin
    test_trixi_run(joinpath(EXAMPLES_DIR, "parameters_hyp_diff_llf.toml"),
            l2   = [0.0001568775108748819, 0.0010259867353406083, 0.0010259867353406382],
            linf = [0.0011986956416590866, 0.006423873516411938, 0.006423873516411938])
  end
  @testset "taal-confirmed parameters_hyp_diff_nonperiodic.toml" begin
    test_trixi_run(joinpath(EXAMPLES_DIR, "parameters_hyp_diff_nonperiodic.toml"),
            l2   = [8.523077654037775e-6, 2.877932365308637e-5, 5.454942769137812e-5],
            linf = [5.484978959957587e-5, 0.00014544895979200218, 0.000324491268921534])
  end
  @testset "taal-confirmed parameters_hyp_diff_upwind.toml" begin
    test_trixi_run(joinpath(EXAMPLES_DIR, "parameters_hyp_diff_upwind.toml"),
            l2   = [5.868147556488962e-6, 3.8051792732628014e-5, 3.8051792732620214e-5],
            linf = [3.70196549871471e-5, 0.0002072058411455302, 0.00020720584114464202])
  end
  @testset "taal-confirmed parameters_advection_mortar.toml" begin
    test_trixi_run(joinpath(EXAMPLES_DIR, "parameters_advection_mortar.toml"),
            l2   = [0.022356422238096973],
            linf = [0.5043638249003257])
  end
  @testset "taal-confirmed parameters_mhd_alfven_wave_mortar.toml" begin
    test_trixi_run(joinpath(EXAMPLES_DIR, "parameters_mhd_alfven_wave_mortar.toml"),
            l2   = [4.608223422391918e-6, 1.6891556053250136e-6, 1.6202140809698534e-6, 1.6994400213969954e-6, 1.4856807283318347e-6, 1.387768347373047e-6, 1.3411738859512443e-6, 1.7155298750074954e-6, 9.799762075600064e-7],
            linf = [3.52219535260101e-5, 1.534468550207224e-5, 1.426263439847919e-5, 1.4421456102198249e-5, 7.743399239257265e-6, 1.019242699840106e-5, 9.862935257842764e-6, 1.6018118328936515e-5, 5.563695788849475e-6],
            t_end=1.0)
  end
  @testset "taal-confirmed parameters_euler_vortex_mortar.toml" begin
    test_trixi_run(joinpath(EXAMPLES_DIR, "parameters_euler_vortex_mortar.toml"),
            l2   = [2.1202421511973067e-6, 2.7929028341308907e-5, 3.7593065314592924e-5, 8.813423453465327e-5],
            linf = [5.93205509794581e-5, 0.0007486675478352023, 0.0008175405566226424, 0.002212267888996422])
  end
  @testset "taal-confirmed parameters_euler_vortex_mortar_split.toml" begin
    test_trixi_run(joinpath(EXAMPLES_DIR, "parameters_euler_vortex_mortar_split.toml"),
            l2   = [2.1203040671963692e-6, 2.8053312800289536e-5, 3.761758762899687e-5, 8.840565162128428e-5],
            linf = [5.900575985384737e-5, 0.0007547236106317801, 0.000817616344069072, 0.0022090204216524967])
  end
  @testset "taal-confirmed parameters_euler_vortex_mortar_split.toml with flux_central" begin
    test_trixi_run(joinpath(EXAMPLES_DIR, "parameters_euler_vortex_mortar_split.toml"),
            l2   = [2.1202421512026147e-6, 2.7929028341288412e-5, 3.759306531457842e-5, 8.813423453452753e-5],
            linf = [5.932055097812583e-5, 0.0007486675478027838, 0.0008175405566221983, 0.0022122678889928693],
            volume_flux = "flux_central")
  end
  @testset "taal-confirmed parameters_euler_vortex_mortar_split.toml with flux_shima_etal" begin
    test_trixi_run(joinpath(EXAMPLES_DIR, "parameters_euler_vortex_mortar_split.toml"),
            l2   = [2.1200379425410095e-6, 2.805632600815787e-5, 3.759464715100376e-5, 8.84115216688531e-5],
            linf = [5.934112354222254e-5, 0.00075475390405777, 0.0008162778009123128, 0.002206991473730824],
            volume_flux = "flux_shima_etal")
  end
  @testset "taal-confirmed parameters_euler_vortex_mortar_split.toml with flux_ranocha" begin
    test_trixi_run(joinpath(EXAMPLES_DIR, "parameters_euler_vortex_mortar_split.toml"),
            l2   = [2.120037931908414e-6, 2.805632845562748e-5, 3.759465243706522e-5, 8.841157002762106e-5],
            linf = [5.934036929955422e-5, 0.0007547536380712039, 0.000816277844819191, 0.0022070017103743567],
            volume_flux = "flux_ranocha")
  end
  @testset "taal-confirmed parameters_euler_vortex_mortar_split_shockcapturing.toml" begin
    test_trixi_run(joinpath(EXAMPLES_DIR, "parameters_euler_vortex_mortar_split_shockcapturing.toml"),
            l2   = [2.1205855860697905e-6, 2.805356649496243e-5, 3.7617723084029226e-5, 8.841527980901164e-5],
            linf = [5.9005286894620035e-5, 0.0007547295163081724, 0.0008176139355887679, 0.0022089993378280326])
  end
  @testset "taal-confirmed parameters_euler_nonperiodic.toml" begin
    test_trixi_run(joinpath(EXAMPLES_DIR, "parameters_euler_nonperiodic.toml"),
            l2   = [2.3652137675654753e-6, 2.1386731303685556e-6, 2.138673130413185e-6, 6.009920290578574e-6],
            linf = [1.4080448659026246e-5, 1.7581818010814487e-5, 1.758181801525538e-5, 5.9568540361709665e-5])
  end
  @testset "taal-confirmed parameters_euler_source_terms.toml" begin
    test_trixi_run(joinpath(EXAMPLES_DIR, "parameters_euler_source_terms.toml"),
            l2   = [8.517783186497567e-7, 1.2350199409361865e-6, 1.2350199409828616e-6, 4.277884398786315e-6],
            linf = [8.357934254688004e-6, 1.0326389653148027e-5, 1.0326389654924384e-5, 4.4961900057316484e-5])
  end
  @testset "taal-confirmed parameters_euler_vortex.toml" begin
    test_trixi_run(joinpath(EXAMPLES_DIR, "parameters_euler_vortex.toml"),
            l2   = [3.6343138447409784e-6, 0.0032111379843728876, 0.0032111482778261658, 0.004545715889714643],
            linf = [7.901869034399045e-5, 0.030511158864742205, 0.030451936462313256, 0.04361908901631395])
  end
  @testset "taal-confirmed parameters_euler_vortex_split_shockcapturing.toml" begin
    test_trixi_run(joinpath(EXAMPLES_DIR, "parameters_euler_vortex_split_shockcapturing.toml"),
            l2   = [3.8034711509468997e-6, 5.561030973129845e-5, 5.563956603258559e-5, 0.00015706441614772137],
            linf = [8.493408680687597e-5, 0.0009610606296146518, 0.0009684675522437791, 0.003075812221315033])
  end
  @testset "taal-confirmed parameters_euler_weak_blast_wave_shockcapturing.toml" begin
    test_trixi_run(joinpath(EXAMPLES_DIR, "parameters_euler_weak_blast_wave_shockcapturing.toml"),
            l2   = [0.05365734539276933, 0.04683903386565478, 0.04684207891980008, 0.19632055541821553],
            linf = [0.18542234326379825, 0.24074440953554058, 0.23261143887822433, 0.687464986948263])
  end
  @testset "taal-confirmed parameters_euler_khi_shockcapturing.toml" begin
    test_trixi_run(joinpath(EXAMPLES_DIR, "parameters_euler_khi_shockcapturing.toml"),
            l2   = [0.002046615463716511, 0.002862576343897973, 0.001971146183422579, 0.004817029337018751],
            linf = [0.024299256322982465, 0.01620011715132652, 0.009869197749689947, 0.02060000394920891],
            t_end = 0.2)
  end
  @testset "taal-confirmed parameters_euler_khi_shockcapturing_amr.toml" begin
    test_trixi_run(joinpath(EXAMPLES_DIR, "parameters_euler_khi_shockcapturing_amr.toml"),
            l2   = [0.001653490458693617, 0.0023814551690212226, 0.0013742646130843919, 0.0031589243386909585],
            linf = [0.022479473484114054, 0.015056172762090259, 0.0070761455651367836, 0.01461791479513419],
            t_end = 0.2)
  end
  @testset "taal-confirmed parameters_euler_blob_shockcapturing_mortar.toml" begin
    test_trixi_run(joinpath(EXAMPLES_DIR, "parameters_euler_blob_shockcapturing_mortar.toml"),
            l2   = [0.22114615931709608, 0.6275614586395163, 0.24325207085080508, 2.9258710844826785],
            linf = [10.524044134146688, 27.5126438384907, 9.454012378298625, 97.53392910067888],
            t_end = 0.5)
  end
  @testset "taal-confirmed parameters_euler_blob_shockcapturing_amr.toml" begin
    test_trixi_run(joinpath(EXAMPLES_DIR, "parameters_euler_blob_shockcapturing_amr.toml"),
            l2   = [0.2016728420174888, 1.1836138789789359, 0.10165086496270354, 5.237367755805095],
            linf = [14.085819993255987, 71.07473800830421, 7.366144023918916, 297.24197965204814],
            t_end = 0.12)
  end
  @testset "taal-confirmed parameters_mhd_orszag_tang.toml" begin
    test_trixi_run(joinpath(EXAMPLES_DIR, "parameters_mhd_orszag_tang.toml"),
            l2   = [0.21662313415818582, 0.2635698604231871, 0.31395699611730377, 0.0, 0.5122276249069517, 0.22914894367706035, 0.34302293430536107, 0.0, 0.0031837261356598232],
            linf = [1.2455340346415893, 0.6656259804847943, 0.8530619473770993, 0.0, 2.762224683447692, 0.6641473992806939, 0.9631804383659317, 0.0, 0.04504842687596635],
            t_end = 0.09)
  end
  # second orszag-tang test added to exercise all components of flux_hll for GLM-MHD
  @testset "taal-confirmed parameters_mhd_orszag_tang.toml with flux_hll" begin
    test_trixi_run(joinpath(EXAMPLES_DIR, "parameters_mhd_orszag_tang.toml"),
            l2   = [0.10797773670821377, 0.20183575429259998, 0.2297276946458608, 0.0, 0.29942847198143785, 0.1567941428185007, 0.24283635408491952, 0.0, 0.0032487131364797796],
            linf = [0.5598159626426933, 0.5095082640545004, 0.655948904969917, 0.0, 0.9809725319955653, 0.39916604098537073, 0.6748429903024491, 0.0, 0.07124312329480051],
            t_end = 0.06, surface_flux = "flux_hll")
  end
  @testset "taal-confirmed parameters_euler_ec_mortar.toml with shock_capturing" begin
    # TODO Taal, remove: This won't fix since we do not port the old-style EC mortars to Taal
    test_trixi_run(joinpath(EXAMPLES_DIR, "parameters_euler_ec_mortar.toml"),
            l2   = [0.04816136246215661, 0.03713041026830962, 0.03713130328181323, 0.1777051166244772],
            linf = [0.3118606868100966, 0.34614370128998007, 0.3460122144359348, 1.1085840270633454],
            volume_integral_type = "shock_capturing")
  end
  @testset "taal-confirmed parameters_advection_basic.toml with restart and t_end=2" begin
    Trixi.run(joinpath(EXAMPLES_DIR, "parameters_advection_basic.toml"))
    test_trixi_run(joinpath(EXAMPLES_DIR, "parameters_advection_basic.toml"),
            l2   = [1.2148032444677485e-5],
            linf = [6.495644794757283e-5],
            t_end = 2,
            restart = true, restart_filename = "out/restart_000040.h5")
  end
  @test_nowarn Trixi.convtest(joinpath(EXAMPLES_DIR, "parameters_advection_basic.toml"), 3)
  @testset "taal-confirmed parameters_euler_blast_wave_shockcapturing_amr.toml" begin
    test_trixi_run(joinpath(EXAMPLES_DIR, "parameters_euler_blast_wave_shockcapturing_amr.toml"), t_end=1.0,
            l2   = [0.6776486969229697, 0.2813026529898539, 0.28130256451012314, 0.7174702524881598],
            linf = [2.8939055423031532, 1.7997630098946864, 1.799711865996927, 3.034122348258568])
  end
  @testset "taal-confirmed differences-to-master parameters_euler_sedov_blast_wave_shockcapturing_amr.toml" begin
    test_trixi_run(joinpath(EXAMPLES_DIR, "parameters_euler_sedov_blast_wave_shockcapturing_amr.toml"), t_end=1.0,
            l2   = [0.4820048896322639, 0.16556563003698888, 0.16556563003698901, 0.643610807739157],
            linf = [2.485752556439829, 1.2870638985941658, 1.2870638985941667, 6.474544663221404])
  end
end

# Coverage test for all initial conditions
@testset "Tests for initial conditions" begin
  # Linear scalar advection
  @testset "taal-confirmed parameters_advection_basic.toml with initial_condition_sin_sin" begin
    test_trixi_run(joinpath(EXAMPLES_DIR, "parameters_advection_basic.toml"),
            l2   = [0.0001424424804667062],
            linf = [0.0007260692243250544],
            n_steps_max = 1,
            initial_condition = "initial_condition_sin_sin")
  end
  @testset "taal-confirmed parameters_advection_basic.toml with initial_condition_constant" begin
    test_trixi_run(joinpath(EXAMPLES_DIR, "parameters_advection_basic.toml"),
            l2   = [6.120436421866528e-16],
            linf = [1.3322676295501878e-15],
            n_steps_max = 1,
            initial_condition = "initial_condition_constant")
  end
  @testset "taal-confirmed parameters_advection_basic.toml with initial_condition_linear_x_y" begin
    test_trixi_run(joinpath(EXAMPLES_DIR, "parameters_advection_basic.toml"),
            l2   = [2.559042358408011e-16],
            linf = [6.8833827526759706e-15],
            n_steps_max = 1,
            initial_condition = "initial_condition_linear_x_y",
            boundary_conditions = "boundary_condition_linear_x_y",
            periodicity=false)
  end
  @testset "taal-confirmed parameters_advection_basic.toml with initial_condition_linear_x" begin
    test_trixi_run(joinpath(EXAMPLES_DIR, "parameters_advection_basic.toml"),
            l2   = [1.5901063275642836e-16],
            linf = [1.5543122344752192e-15],
            n_steps_max = 1,
            initial_condition = "initial_condition_linear_x",
            boundary_conditions = "boundary_condition_linear_x",
            periodicity=false)
  end
  @testset "taal-confirmed parameters_advection_basic.toml with initial_condition_linear_y" begin
    test_trixi_run(joinpath(EXAMPLES_DIR, "parameters_advection_basic.toml"),
            l2   = [1.597250146891042e-16],
            linf = [3.552713678800501e-15],
            n_steps_max = 1,
            initial_condition = "initial_condition_linear_y",
            boundary_conditions = "boundary_condition_linear_y",
            periodicity=false)
  end
  # Compressible Euler
  @testset "taal-confirmed parameters_euler_vortex.toml one step with initial_condition_density_pulse" begin
    test_trixi_run(joinpath(EXAMPLES_DIR, "parameters_euler_vortex.toml"),
            l2   = [0.003201074851451383, 0.0032010748514513724, 0.0032010748514513716, 0.0032010748514513794],
            linf = [0.043716393835876444, 0.043716393835876444, 0.043716393835876, 0.04371639383587578],
            n_steps_max = 1,
            initial_condition = "initial_condition_density_pulse")
  end
  @testset "taal-confirmed parameters_euler_vortex.toml one step with initial_condition_pressure_pulse" begin
    test_trixi_run(joinpath(EXAMPLES_DIR, "parameters_euler_vortex.toml"),
            l2   = [0.00018950189533270512, 0.0020542290689775757, 0.002054229068977579, 0.01013381064979542],
            linf = [0.004763284475434837, 0.028439617580275578, 0.028439617580275467, 0.13640572175447918],
            n_steps_max = 1,
            initial_condition = "initial_condition_pressure_pulse")
  end
  @testset "taal-confirmed parameters_euler_vortex.toml one step with initial_condition_density_pressure_pulse" begin
    test_trixi_run(joinpath(EXAMPLES_DIR, "parameters_euler_vortex.toml"),
            l2   = [0.0031880440066425803, 0.0050397619349217574, 0.005039761934921767, 0.014340770024960708],
            linf = [0.04279723800834989, 0.06783565847184869, 0.06783565847184914, 0.19291274039254347],
            n_steps_max = 1,
            initial_condition = "initial_condition_density_pressure_pulse")
  end
  @testset "taal-confirmed parameters_euler_vortex.toml one step with initial_condition_constant" begin
    test_trixi_run(joinpath(EXAMPLES_DIR, "parameters_euler_vortex.toml"),
            l2   = [2.359732835648237e-16, 1.088770274131804e-16, 1.1814939065033234e-16, 1.980283448445849e-15],
            linf = [4.440892098500626e-16, 2.914335439641036e-16, 4.718447854656915e-16, 3.552713678800501e-15],
            n_steps_max = 1,
            initial_condition = "initial_condition_constant")
  end
  @testset "taal-confirmed differences-to-master parameters_euler_sedov_blast_wave_shockcapturing_amr.toml one step" begin
    test_trixi_run(joinpath(EXAMPLES_DIR, "parameters_euler_sedov_blast_wave_shockcapturing_amr.toml"),
            l2   = [0.0021037031798961936, 0.010667428589443041, 0.010667428589443027, 0.11041565217737695],
            linf = [0.11754829172684966, 0.7227194329885249, 0.7227194329885249, 5.42708544137305],
            n_steps_max = 1)
  end
  @testset "taal-confirmed differences-to-master parameters_euler_sedov_blast_wave_shockcapturing_amr.toml one step with initial_condition_medium_sedov_blast_wave" begin
    test_trixi_run(joinpath(EXAMPLES_DIR, "parameters_euler_sedov_blast_wave_shockcapturing_amr.toml"),
            l2   = [0.002102553227287478, 0.01066154856802227, 0.010661548568022277, 0.11037470219676422],
            linf = [0.11749257043751615, 0.7223475657303381, 0.7223475657303381, 5.425015419074852],
            n_steps_max = 1,
            initial_condition = "initial_condition_medium_sedov_blast_wave")
  end

  # GLM-MHD
  @testset "taal-confirmed parameters_mhd_alfven_wave.toml one step with initial_condition_constant" begin
    test_trixi_run(joinpath(EXAMPLES_DIR, "parameters_mhd_alfven_wave.toml"),
            l2   = [1.9377318494777845e-16, 2.0108417179968547e-16, 4.706803550379074e-16, 9.849916218369067e-17, 9.578096259273606e-15, 4.995499731290712e-16, 2.72017579525395e-16, 9.963303137205655e-17, 1.7656549191657418e-16],
            linf = [4.440892098500626e-16, 7.494005416219807e-16, 1.7763568394002505e-15, 2.220446049250313e-16, 2.1316282072803006e-14, 1.3322676295501878e-15, 8.881784197001252e-16, 2.220446049250313e-16, 7.414582366945819e-16],
            n_steps_max = 1,
            initial_condition = "initial_condition_constant")
  end
  @testset "taal-confirmed parameters_mhd_rotor.toml" begin
    test_trixi_run(joinpath(EXAMPLES_DIR, "parameters_mhd_rotor.toml"),
            l2   = [1.2428140306560267, 1.7997194450337968, 1.6900291785233619, 0.0, 2.2634513724749357, 0.212710214030601, 0.233276208669814, 0.0, 0.0026495769095112244],
            linf = [10.47092272020676, 14.061476930703114, 15.55246880748034, 0.0, 16.619962600809156, 1.3033533536346604, 1.4125607690546562, 0.0, 0.07338769474671016],
            t_end = 0.05)
  end
  @testset "taal-confirmed parameters_mhd_blast_wave.toml" begin
    test_trixi_run(joinpath(EXAMPLES_DIR, "parameters_mhd_blast_wave.toml"),
            l2   = [0.1757875762080873, 3.8532519959458216, 2.4727214755520532, 0.0, 355.0835842161213, 2.3454068130466776, 1.3916366548136, 0.0, 0.028930416439621368],
            linf = [1.5948842870594393, 44.31605592215359, 12.854945034752436, 0.0, 2207.513124699695, 12.706623740109995, 8.987432397883575, 0.0, 0.4980365769225257],
            t_end = 0.003)
  end
end

# Clean up afterwards: delete Trixi output directory
@test_nowarn rm(outdir, recursive=true)

end #module
