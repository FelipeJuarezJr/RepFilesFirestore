# RepFiles - Reptile Management App

A comprehensive web application for managing reptile collections, breeding projects, and care schedules.

## Features

### Authentication System
- **Login/Register Pages**: Beautiful, responsive authentication screens with nocturnal theme support
- **Password Strength Indicator**: Real-time password strength checking during registration
- **Social Authentication**: Placeholder for Google and GitHub OAuth integration
- **Session Management**: Persistent login with "Remember Me" functionality
- **User Dropdown**: Profile menu with logout functionality

### Core Features
- **Dashboard**: Overview of collection statistics and recent activity
- **Reptile Management**: Add, edit, and track individual reptiles
- **Breeding Projects**: Manage breeding pairs and genetics calculations
- **Schedule & Tasks**: Calendar-based task management
- **Inventory Tracking**: Food and supply management with cost tracking
- **Reports & Analytics**: Comprehensive reporting and data visualization

### Design Features
- **Nocturnal Theme**: Dark mode optimized for low-light environments
- **Responsive Design**: Works seamlessly on desktop, tablet, and mobile
- **Modern UI**: Clean, intuitive interface with smooth animations
- **Accessibility**: Keyboard navigation and screen reader support

## Getting Started

### Prerequisites
- Modern web browser (Chrome, Firefox, Safari, Edge)
- No server setup required - runs entirely in the browser

### Installation
1. Clone or download the repository
2. Open `login.html` in your web browser
3. Create an account or sign in with any email/password combination (demo mode)

### Usage
1. **Registration**: Fill out the registration form with your details
2. **Login**: Use your email and password to access the application
3. **Navigation**: Use the sidebar to navigate between different sections
4. **Theme Toggle**: Switch between light and dark themes using the moon/sun icon
5. **User Menu**: Click your profile icon to access account options and logout

## File Structure

```
RepFilesFirestore/
├── index.html          # Main application interface
├── login.html          # Login page
├── register.html       # Registration page
├── styles.css          # Main stylesheet with theme support
├── script.js           # Main application logic
├── auth.js             # Authentication functionality
├── firebase.json       # Firebase configuration
└── README.md           # This file
```

## Authentication System

### Features
- **Form Validation**: Client-side validation for all input fields
- **Password Security**: Strength indicator and confirmation matching
- **Session Persistence**: Optional "Remember Me" functionality
- **Responsive Design**: Optimized for all screen sizes
- **Theme Integration**: Consistent with the main application theme

### Demo Mode
For demonstration purposes, the authentication system accepts any valid email/password combination. In a production environment, this would be replaced with proper backend authentication.

### User Data Storage
User data is stored in browser localStorage/sessionStorage for demo purposes. In production, this would be handled by a secure backend database.

## Theme System

The application features a sophisticated theme system with:

### Nocturnal Mode (Dark Theme)
- Optimized for low-light environments
- Green accent colors for better visibility
- Reduced eye strain during extended use

### Diurnal Mode (Light Theme)
- Traditional light interface
- High contrast for daytime use
- Professional appearance

### Theme Persistence
- Theme preference is saved in localStorage
- Automatically applied on subsequent visits
- Can be toggled from any page

## Browser Compatibility

- Chrome 80+
- Firefox 75+
- Safari 13+
- Edge 80+

## Future Enhancements

- [ ] Backend integration with Firebase/Firestore
- [ ] Real social authentication (Google, GitHub)
- [ ] Image upload and management
- [ ] Advanced breeding genetics calculator
- [ ] Mobile app development
- [ ] Multi-user collaboration features
- [ ] Export/import functionality
- [ ] Advanced reporting and analytics

## Contributing

This is a demo project forked from ReptiGram. Feel free to explore and modify the code for your own reptile management needs.

## License

This project is for educational and demonstration purposes. 