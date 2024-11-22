# 🦋 Butterfly Classification App (Species of Gujarat)

## 👩‍🏫 Mentorship  
- **Dr. Swapnil Lokhande**

---

**Team Members**  
- Smit Shah (202251122)  
- Heet Shah (202251121)  
- Parv Thummar (202251143)  
- Tanuj Saini (202251141)
---

## 🔗 Links & Resources  

### **Deployed App Links**  
- **Android App**: [Download the Butterfly Classification App](https://drive.google.com/file/d/1NF8f88E1Wxuu6REl3n_RPqzr3AkTmdYZ/view?usp=sharing)  
- **Access the Model directly here ->**: [Web App](https://huggingface.co/spaces/sssdfcfdsf/deploy)

### **Reports & Posters**  
- **Final Report**: [View the Report](https://drive.google.com/file/d/16aZpKaP9xlw18V1FQxZm0L5xfsrFWWeF/view?usp=sharing)  
- **Poster**: [Download the Poster](https://drive.google.com/file/d/1NZ9PfLoxufdv_cIioBeBsTqKiY-EGWMa/view?usp=sharing)  

### **Dataset**  
- **Dataset Link**: [Access the Dataset](https://drive.google.com/drive/folders/1FlGlNmMXOCif4-bdxzxSEDdbtIW5JQX-)  
- **Dataset Curated From**: [iFoundButterflies](https://www.ifoundbutterflies.org/)

### **Model Checkpoints**  
- **VGG-16 Model Checkpoints**: [50 EPOCHS](https://drive.google.com/file/d/1TbVPD2jNiFNe6hclk0Uxnk4FVGyTQhk7/view?usp=sharing)  

### **SAM Models**  
- **Github Reporitory**: [Repo](https://github.com/facebookresearch/segment-anything/tree/main) 

- **SAM Model used for Project**:
  - **vit_l**: [Download vit_l (1.5GB)](https://dl.fbaipublicfiles.com/segment_anything/sam_vit_l_0b3195.pth)

- **Other Available SAM Models**:
  - **vit_b**: [Download base model(0.5GB)](https://dl.fbaipublicfiles.com/segment_anything/sam_vit_b_01ec64.pth)
  - **vit_h**: [Download large model (2.5GB)](https://dl.fbaipublicfiles.com/segment_anything/sam_vit_h_4b8939.pth)
---

## 📄 SAM Outputs  
- **SAM Model Outputs**: [for our dataset](https://docs.google.com/document/d/15F2JfelWtwPOqW_LfRB1afMZb944jh_0NJqs6ZJO8TY/edit?usp=sharing)



## 📖 Introduction  
Our project focuses on developing a **Flutter-based mobile application** designed to identify butterfly species native to Gujarat. Combining state-of-the-art AI technologies with an intuitive mobile experience, the app provides:

- **Real-time butterfly identification** through image segmentation and classification.
- A **comprehensive catalog of 109 butterfly species** with detailed information on each.
- Tools tailored for **researchers, enthusiasts, and conservationists** to promote biodiversity awareness and conservation efforts.

### Key Highlights
- Utilizes **SAM (Segment Anything Model)** for precise image segmentation.
- Achieves **85% classification accuracy** using a fine-tuned VGG-16 model.
- Serves as an educational and practical tool for biodiversity studies.

---

## 🌟 Features  

- **Real-time Butterfly Identification**  
  - Uses SAM for precise segmentation and VGG-16 for accurate classification.  
  - Supports multiple image formats like JPEG, PNG, and JPG.  

- **Species Catalog**  
  - A catalog of **109 butterfly species** native to Gujarat, showcasing detailed information for each.  

- **User History and Profile**  
  - Allows login/signup functionality to maintain a personalized user experience.  
  - Tracks identification history for future reference.  

- **Direct Online Search**  
  - Clickable links for each species enable instant searches for additional information on Google.  

---

## 🧑‍💻 Methodology  

### 1. **Data Collection and Preprocessing**  
   - Collected images of butterfly species from Gujarat from reliable online sources.  
   - Applied preprocessing techniques to optimize the dataset for training.  

### 2. **Model Selection**  
   - Tested multiple architectures, including ResNet and DenseNet.  
   - Selected **VGG-16** for its superior performance, achieving **85% accuracy**.  

### 3. **Image Segmentation**  
   - Implemented **SAM** to isolate butterflies from their surroundings.  
   - Enhanced classification reliability by focusing on segmented objects.  

### 4. **Flutter App Development**  
   - Designed and developed a user-friendly app with key functionalities:  
     - Login/Signup  
     - Species catalog  
     - History tracking  

---

## 🔧 Tech Stack  

| **Component**           | **Technology Used**        |  
|--------------------------|----------------------------|  
| **Frontend**            | Flutter                   |  
| **Backend**             | Firebase                  |  
| **Image Segmentation**  | SAM (Segment Anything Model) |  
| **Classification Model**| VGG-16 (Fine-tuned)       |  

---

## 📈 Future Scopes  

- Expand the catalog to include **national butterfly species** beyond Gujarat.  
- Develop a **community-verified and research-backed repository** for consistent updates.  
- Incorporate **local sightings and academic contributions** to enhance the app's richness.  

---

## 📸 Screenshots and Visuals  

### Masking BY SAM Model
![SAM Model Masking](https://github.com/user-attachments/assets/efbc3311-3a8f-414f-8f3b-6395a8ad8b3e)
---

## 📅 Future Enhancements

- **Expand to National and International Species**:  
  - Increase the app's reach by adding species from different regions and countries.
  
- **Community Contributions**:  
  - Create a platform for users to contribute new species sightings and academic content.

---

This **Butterfly Classification App** is an excellent tool for promoting biodiversity awareness, providing researchers and enthusiasts with a valuable resource for identifying and learning about butterfly species in Gujarat. 🌿

---
