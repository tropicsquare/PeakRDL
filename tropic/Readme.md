This folder contains PeakRDL packaging for Tropic Square development environment.
It packages PeakRDL subtools (uvm, reg-block) into one Python virtual environment.

All PeakRDL repositories are forked from mainline by Tropic Square Github organization.
This repository submodules all the other repositories (peakrdl-regblock, peakrdl-html, etc...)

The version of submodules does not necessarily correspond to the version used by mainline
packaging (in pyproject.toml in root of this repository).
Submodules are bumped-up arbitrarily as new features are added to sub-tools.

Version of the released tool corresponds to the mainline version with appendix:

`+T.<VERSION_NUM>`

where `<VERSION_NUM>` is padded to three digits by zero.

So, e.g. a first released version from mainline version `1.1.0` is:

`1.1.0+T.001`

When contributing features to the PeakRDL Tropic Square fork there are following goals:
1. Quickly get new feature implemented and deployed in Tropic Square environment.
   This is important to get new features without the need to wait for mainline packaging.
2. Mainline new feature so that the Tropic Square fork does not diverge from mainline
   (and rebase is eventually possible).

These two points go one against other in some cases. Therefore, if a new feature is
implemented in Tropic Square fork, there shall be an attempt to submit pull-request
in mainline PeakRDL.

When you implement new feature, then:
1. Bump-up corresponding submodule accordingly
2. Open merge request to mainline repository
3. Get your feature to `master` of PeakRDL Tropic Square fork (if this change is
   in `peakrdl` itself)
4. Checkout `tropic-packaging`. Rebase the branch to master (of Tropic Square fork).
5. Bump sumbodule if the feature was implemented in sub-tool.
6. Bump-up `<VERSION_NUM>` in `tropic/pyproject.toml` and `src/peakrdl/__about__.py`
7. Deploy the tool to Tropic Square development (manually launching `install_peakrdl.sh`)

This-way you will get "quick" new version available in Tropic environment.
It may happen that it will take time (and changes needed) to get the feature into the
mainline repository and then into mainline packaged version (peakRDL and sub-tool version
in `pyproject.toml` in root of this repository).

Thus e.g. if you add new feature, you will get release:

`1.1.0+T.2`

but, this feature will only reach mainline in some time (e.g. in version `1.3.0`).

To get the mainline changes, we should keep rebasing our repositories to the mainline.
This is valid for this repo, as well as sub-tool repos. If you rebase sub-tool repository
and bump its submodule, then bump-up `<VERSION_NUM>`.
If you rebase this repository and mainline repository has newer version tag,
set `<VERSION_NUM>` back to 1.
This-way we will be able to track upstream versions.

Note that if we don't attempt to merge our changes to mainline, rebasing will start becoming
increasingly difficult. If merging to mainline requires changes or iterations, don't hesitate
to apply them and release new and new `<VERSION_NUM>`.





