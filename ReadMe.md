#Affine Structure from Motion

In this part of the assignment we address the problem of recovering the three-dimensional structure of a scene from a sequence of pictures. The task here is to estimate the same information from a potentially large number of pictures, and switch from a mostly geometric approach to an algebraic one. The set of affine images of a scene is first shown to also exhibit an affine structure, which is then exploited to derive the factorization method of Tomasi and Kanade [1992] for estimating the affine structure and motion of a scene from an image sequence.

## What does it Do:
The aim is to use the tracked points provided for the given video frames to recover both structure and the motion of the camera using the method described in the paper above by Tomasi and Kanade.

## Conclusion
* The method is simple and robust for shape reconstruction tasks.
* It affords simple techniques for motion-based image segmentation with applications including interactive image synthesis in the augmented reality domain.
* It also finds its application in wide variety of fields like Computer Aided Geometric Design(CAGD), Computer Graphics, Computer Animation, Computer Vision, medical imaging, computational science, Virtual Reality, digital media etc.,
* The main contributors to the error are points which drift into flat regions in which no motion can be observed causing the points to further drift away from the ground truth.

### Usage: 
Run the main.m in MATLAB. The input frames have not been included and hence to run successfully, you will need to put the input frames in the root folder. However, the code with run till 3d reconstruction since it doesnt require the input frames and since the measurement matrix has been included in the directory.