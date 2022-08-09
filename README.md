<!-- Improved compatibility of back to top link: See: https://github.com/othneildrew/Best-README-Template/pull/73 -->
<a name="readme-top"></a>


<!-- PROJECT SHIELDS -->
<!--
*** I'm using markdown "reference style" links for readability.
*** Reference links are enclosed in brackets [ ] instead of parentheses ( ).
*** See the bottom of this document for the declaration of the reference variables
*** for contributors-url, forks-url, etc. This is an optional, concise syntax you may use.
*** https://www.markdownguide.org/basic-syntax/#reference-style-links
-->
[![Contributors][contributors-shield]][contributors-url]
[![Forks][forks-shield]][forks-url]
[![Stargazers][stars-shield]][stars-url]
[![Issues][issues-shield]][issues-url]
[![MIT License][license-shield]][license-url]
[![LinkedIn][linkedin-shield]][linkedin-url]



<!-- PROJECT LOGO -->
<br />
<div align="center">
  <a href="https://github.com/ItayCoifman/V3D_Matlab">
    <img src="figures/logo.png" alt="Logo" width="300" height="150">
  </a>

<h3 align="center">V3D pipeline MATLAB wrappers pack</h3>
	<!--
  <p align="center">
    project_description
    <br />
    <a href="https://github.com/ItayCoifman/V3D_Matlab"><strong>Explore the docs »</strong></a>
    <br />
    <br />
    <a href="https://github.com/ItayCoifman/V3D_Matlab">View Demo</a>
    ·
    <a href="https://github.com/ItayCoifman/V3D_Matlab/issues">Report Bug</a>
    ·
    <a href="https://github.com/ItayCoifman/V3D_Matlab/issues">Request Feature</a>
  </p>
  -->
</div>



<!-- TABLE OF CONTENTS -->
<details>
  <summary>Table of Contents</summary>
  <ol>
    <li>
      <a href="#about-the-project">About The Project</a>
      <ul>
        <li><a href="#built-with">Built With</a></li>
      </ul>
    </li>
    <li>
      <a href="#getting-started">Getting Started</a>
      <ul>
        <li><a href="#prerequisites">Prerequisites</a></li>
        <li><a href="#installation">Installation</a></li>
      </ul>
    </li>
    <li><a href="#usage">Usage</a></li>
    <li><a href="#roadmap">Roadmap</a></li>
    <li><a href="#contributing">Contributing</a></li>
    <li><a href="#license">License</a></li>
    <li><a href="#contact">Contact</a></li>
    <li><a href="#acknowledgments">Acknowledgments</a></li>
  </ol>
</details>



<!-- ABOUT THE PROJECT -->
## About The Project

<!--[![Product Name Screen Shot][product-screenshot]](https://example.com)-->
Creating a V3D pipeline is a hard mission and requires a lot of technical and scientific knowledge. Manipulating an existing pipeline is not always easy and manipulating it dynamically and automatically via code is an even more complicated task. 
 As an addition to this paper, we introduce the MATLAB V3D wrapper package. This code package is aimed to create, and launch V3D pipelines using intuitive MATLAB commands, while offering the user dynamic change at each pipeline easily.
In this paper, this dynamic change was used to iterate through all subjects and all trials, change each trial model to fit the desired weight attached (changeMetric), and automate the whole process so the hole experiment can be processed through V3D to MATLAB tables using a single MATLAB script.


<p align="right">(<a href="#readme-top">back to top</a>)</p>



### Built With

* [![Matlab][Matlab-logo]][Matlab-url]


<p align="right">(<a href="#readme-top">back to top</a>)</p>



<!-- GETTING STARTED -->
## Getting Started
a good starting point will be by altering the example script.

### Prerequisites

C- motion - Visual-3D, licensed need to be instaled for launcing pipelines.


### Installation


1. Clone the repo
   ```sh
   git clone https://github.com/ItayCoifman/V3D_Matlab.git
   ```
2. set Path via matlab to the cloned project

3. change path_V3D at the exmaple file to the relevant directory.



<p align="right">(<a href="#readme-top">back to top</a>)</p>



<!-- USAGE EXAMPLES -->
## Usage
<p align="left">
Optional – added features that can be added to the pipeline through the MATLAB command, for example, scaleModel(path_pipeLine, ‘path_staticTrial’,…), if the optional fields are not used, the pipeline will use the V3D default (typically it will pop up a window to choose the relevant file via the V3D GUI. 
Model is declared by the path to the static trial, i.e., ‘path_staticTrial’ = ‘modelName’
</p>

<h3> Wrapper package function</h3>
<p align="left">
<b>createPipeLine(path_pipeLine)</b> creates an empty pipeline, where all data is going to be stored in.
</p>
<p align="left">
<b>scaleModel(path_pipeLine)</b> – creates a hybrid model, using ‘path_staticTrial’ (optional), apply scale on the template model ‘path_GenericModel’ (optional), sets model subject weight and height by using ‘subjectHeight’ and ‘subjectWeight’ (optional).
</p>
<p align="left">
<b>changeMetric(path_pipeLine,METRIC_NAME,METRIC_VALUE)</b> – changes model metric using the Metric_Name. change the metric to Metric_Value. The change will be applied on ‘modelName’ (optional).
*NOTE! If ‘modelName’ is not used, the metric change will be applied on the last model that was scaled.
*NOTE! metric need to exist at the model.
</p>
<p align="left">
<b> addMotion(path pipeline, varargin) </b> – add motion to the workspace and assign a biomechanical model ‘modelName’ (optional) to analyze it. 
</p>
<p align="left">
<b>fixForcePlateData (path pipeline)</b> – a lot of times small adjustments need to be applied to the force plate data, so V3D can work fine.
Each lab will need to adjust this function to its force plate type, more info can be found here.
</p>
<p align="left">
<b>lowPassMotionCapture(path_pipeLine,'cutoff',cutOff)</b> -  apply V3D lowpass filter on MOCAP data, using  ‘cutoff’(default -20Hz).
</p>
<p align="left">
<b>lowPassAnalog(path_pipeLine,'cutoff',cutOff)</b> -  apply V3D lowpass filter on MOCAP data, using  ‘cutoff’(default -10Hz).
</p>
<p align="left">
<b>calculateJoint(path_pipeLine, functionName, jointName)</b>
function Names:
'JOINT_ANGLE','JOINT_MOMENT','JOINT_POWER','JOINT_VELOCITY'
joints: 'hip','knee','ankle'
direction (optional) defaults 'R', for left side calculations use 'L’.
</p>
<p align="left">
<b>exportMatFile(path_pipeLine)</b>- export all relevant calculations for MATLAB files. Note! Right now, this function export, angels, angular velocity, moments, and powers of the right side of the lower extremity (hip, knee, ankle). This function needs to be more generalized to better fit the general case.
</p>
<p align="left">
<b>saveWorkSpace – save workspace.cmz, if ‘path’(optional)</b>, is used, the file can be saved with a specific name at a specific destination folder.
</p>
<p align="left">
<b>getV3DTabels(v3dData\ v3dPath) </b>– utility function that read all the exportMatFile data and transfer it to MATLAB tables.
</p>



<p align="right">(<a href="#readme-top">back to top</a>)</p>



<!-- ROADMAP 
## Roadmap

- [ ] Feature 1
- [ ] Feature 2
- [ ] Feature 3
    - [ ] Nested Feature

See the [open issues](https://github.com/ItayCoifman/V3D_Matlab/issues) for a full list of proposed features (and known issues).

<p align="right">(<a href="#readme-top">back to top</a>)</p>
-->


<!-- CONTRIBUTING
## Contributing

Contributions are what make the open source community such an amazing place to learn, inspire, and create. Any contributions you make are **greatly appreciated**.

If you have a suggestion that would make this better, please fork the repo and create a pull request. You can also simply open an issue with the tag "enhancement".
Don't forget to give the project a star! Thanks again!

1. Fork the Project
2. Create your Feature Branch (`git checkout -b feature/AmazingFeature`)
3. Commit your Changes (`git commit -m 'Add some AmazingFeature'`)
4. Push to the Branch (`git push origin feature/AmazingFeature`)
5. Open a Pull Request

<p align="right">(<a href="#readme-top">back to top</a>)</p>

 -->

<!-- LICENSE -->
## License

Distributed under the MIT License. See `LICENSE.txt` for more information.

<p align="right">(<a href="#readme-top">back to top</a>)</p>



<!-- CONTACT -->
## Contact

Project Link: [https://github.com/ItayCoifman/V3D_Matlab](https://github.com/ItayCoifman/V3D_Matlab)

<p align="right">(<a href="#readme-top">back to top</a>)</p>



<!-- ACKNOWLEDGMENTS 
## Acknowledgments

* []()
* []()
* []()

<p align="right">(<a href="#readme-top">back to top</a>)</p>
-->



<!-- MARKDOWN LINKS & IMAGES -->
<!-- https://www.markdownguide.org/basic-syntax/#reference-style-links -->
[contributors-shield]: https://img.shields.io/github/contributors/ItayCoifman/V3D_Matlab.svg?style=for-the-badge
[contributors-url]: https://github.com/ItayCoifman/V3D_Matlab/graphs/contributors
[forks-shield]: https://img.shields.io/github/forks/ItayCoifman/V3D_Matlab.svg?style=for-the-badge
[forks-url]: https://github.com/ItayCoifman/V3D_Matlab/network/members
[stars-shield]: https://img.shields.io/github/stars/ItayCoifman/V3D_Matlab.svg?style=for-the-badge
[stars-url]: https://github.com/ItayCoifman/V3D_Matlab/stargazers
[issues-shield]: https://img.shields.io/github/issues/ItayCoifman/V3D_Matlab.svg?style=for-the-badge
[issues-url]: https://github.com/ItayCoifman/V3D_Matlab/issues
[license-shield]: https://img.shields.io/github/license/ItayCoifman/V3D_Matlab.svg?style=for-the-badge
[license-url]: https://github.com/ItayCoifman/V3D_Matlab/blob/master/LICENSE.txt
[linkedin-shield]: https://img.shields.io/badge/-LinkedIn-black.svg?style=for-the-badge&logo=linkedin&colorB=555
[linkedin-url]: https://linkedin.com/in/itay-coifman-959235199
[product-screenshot]: images/screenshot.png
[Next.js]: https://img.shields.io/badge/next.js-000000?style=for-the-badge&logo=nextdotjs&logoColor=white
[Next-url]: https://nextjs.org/

[Matlab-logo]: https://img.shields.io/badge/MATLAB-R2022a-BLUE.svg
[Matlab-url]: https://www.mathworks.com/products/matlab.html

[React.js]: https://img.shields.io/badge/React-20232A?style=for-the-badge&logo=react&logoColor=61DAFB
[React-url]: https://reactjs.org/
[Vue.js]: https://img.shields.io/badge/Vue.js-35495E?style=for-the-badge&logo=vuedotjs&logoColor=4FC08D
[Vue-url]: https://vuejs.org/
[Angular.io]: https://img.shields.io/badge/Angular-DD0031?style=for-the-badge&logo=angular&logoColor=white
[Angular-url]: https://angular.io/
[Svelte.dev]: https://img.shields.io/badge/Svelte-4A4A55?style=for-the-badge&logo=svelte&logoColor=FF3E00
[Svelte-url]: https://svelte.dev/
[Laravel.com]: https://img.shields.io/badge/Laravel-FF2D20?style=for-the-badge&logo=laravel&logoColor=white
[Laravel-url]: https://laravel.com
[Bootstrap.com]: https://img.shields.io/badge/Bootstrap-563D7C?style=for-the-badge&logo=bootstrap&logoColor=white
[Bootstrap-url]: https://getbootstrap.com
[JQuery.com]: https://img.shields.io/badge/jQuery-0769AD?style=for-the-badge&logo=jquery&logoColor=white
[JQuery-url]: https://jquery.com 


