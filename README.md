# RepFilesFirestore - Reptile Management System

A comprehensive web-based application for managing reptile collections, tracking health, breeding programs, and maintaining detailed records for herpetoculture enthusiasts.

## 🦎 Features

### Reptile Profiles
- **Species, name, hatch date, weight, health status**
- Complete individual animal records with detailed information
- Track growth and development milestones

### Photos and Notes
- **Photos and notes per animal**
- Visual documentation of each reptile
- Detailed notes for health, behavior, and care observations

### Feed/Water Logs
- **Track feeding, watering, shedding, and defecation**
- Comprehensive logging system for daily care activities
- **Optionally set reminders or recurring tasks**
- Automated notifications for feeding schedules and health checks

### Weight Charts
- **Graph of weight over time**
- Visual tracking of growth patterns
- Data visualization for health monitoring

### Breeding Tracker
- **Pairings, clutches, incubation, and hatchlings**
- Complete breeding program management
- Track genetic lines and breeding success rates

### Media Uploads
- **Per reptile, clutch, or general album**
- Organized photo galleries
- Document breeding projects and individual animals

### Lineage / Genetics Tracker
- **Sire/dame linking and lineage history**
- Maintain genetic records and pedigrees
- Track inheritance patterns and breeding history

### Export / Backup
- **Export to PDF or spreadsheet**
- Backup your data in multiple formats
- Share records with veterinarians or other breeders

### Web + Mobile Support
- **App works on all screen sizes**
- Responsive design for desktop, tablet, and mobile devices
- Access your reptile records anywhere, anytime

## 🚀 Getting Started

### Prerequisites
- Modern web browser
- Firebase account (for data storage)

### Installation
1. Clone the repository:
   ```bash
   git clone https://github.com/FelipeJuarezJr/RepFilesFirestore.git
   ```

2. Open `index.html` in your web browser

3. Configure Firebase settings in `firebase.json` and `.firebaserc`

## 📱 Usage

### Adding a New Reptile
1. Navigate to the "Add Reptile" section
2. Fill in species, name, hatch date, and initial weight
3. Upload photos and add initial notes
4. Save the profile

### Logging Activities
1. Select the reptile from your collection
2. Choose the activity type (feeding, watering, shedding, etc.)
3. Add details and optional photos
4. Set reminders if needed

### Breeding Management
1. Create breeding pairs
2. Track clutch development
3. Monitor incubation conditions
4. Record hatchling data

## 🛠️ Technology Stack

- **Frontend**: HTML5, CSS3, JavaScript
- **Backend**: Firebase Firestore
- **Storage**: Firebase Storage (for media files)
- **Authentication**: Firebase Auth (planned)

## 📊 Data Structure

The application uses Firebase Firestore to store:
- Reptile profiles and metadata
- Activity logs and health records
- Breeding data and lineage information
- Media file references

## 🔒 Privacy & Security

- All data is stored securely in Firebase
- User authentication and authorization (coming soon)
- Data backup and export capabilities

## 🤝 Contributing

1. Fork the repository
2. Create a feature branch (`git checkout -b feature/AmazingFeature`)
3. Commit your changes (`git commit -m 'Add some AmazingFeature'`)
4. Push to the branch (`git push origin feature/AmazingFeature`)
5. Open a Pull Request

## 📄 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## 🙏 Acknowledgments

- Built for the herpetoculture community
- Inspired by the need for better reptile management tools
- Special thanks to reptile breeders and enthusiasts for feedback

## 📞 Support

For support, please open an issue on GitHub or contact the development team.

---

**RepFilesFirestore** - Making reptile management easier, one scale at a time! 🦎✨ 