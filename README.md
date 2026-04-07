# IoT Healthcare Monitoring System

A comprehensive IoT healthcare monitoring system with real-time vital signs tracking, AI-powered health assistance, and automated alert management.

## 🚀 Features

### Core Functionality
- **Real-time Vital Signs Monitoring**: Track heart rate, blood pressure, temperature, oxygen saturation, and weight
- **Patient Management**: Complete patient records with medical history and emergency contacts
- **Device Management**: Register and monitor IoT healthcare devices
- **AI Health Assistant**: Get personalized health advice and symptom analysis
- **Automated Alerts**: Intelligent alert system for abnormal vital signs
- **Health Analytics**: Comprehensive health score calculation and trend analysis

### Technical Features
- **RESTful API**: Flask-based backend with comprehensive endpoints
- **Real-time Database**: Firebase Realtime Database for instant data synchronization
- **Responsive Frontend**: Modern web interface with interactive charts
- **AI Integration**: OpenAI-powered chatbot for health assistance
- **Cross-platform**: Works on desktop, tablet, and mobile devices

## 🏗️ Architecture

```
├── backend/                 # Flask API Server
│   ├── app/
│   │   ├── __init__.py     # Flask app factory
│   │   ├── services/       # Business logic services
│   │   ├── routes/         # API endpoints
│   │   └── models/         # Data models
│   ├── run.py              # Application entry point
│   └── requirements.txt    # Python dependencies
├── frontend/               # Web Interface
│   ├── index.html          # Main application
│   ├── css/styles.css      # Styling
│   └── js/                 # JavaScript modules
└── docs/                   # Documentation
```

## 📋 Prerequisites

- **Python 3.8+**
- **Node.js** (for development tools)
- **Firebase Project** with Realtime Database
- **OpenAI API Key** (optional, for AI features)

## 🔧 Installation & Setup

### 1. Clone the Repository
```bash
git clone <repository-url>
cd iot-healthcare-system
```

### 2. Backend Setup

#### Install Python Dependencies
```bash
cd backend
pip install -r requirements.txt
```

#### Configure Environment Variables
```bash
# Copy the example environment file
cp .env.example .env
```

Edit `.env` with your configuration:
```env
# Flask Configuration
FLASK_ENV=development
FLASK_DEBUG=True
SECRET_KEY=your-secret-key-here

# Firebase Configuration
FIREBASE_PROJECT_ID=your-project-id
FIREBASE_PRIVATE_KEY_ID=your-private-key-id
FIREBASE_PRIVATE_KEY="-----BEGIN PRIVATE KEY-----\nYOUR_PRIVATE_KEY\n-----END PRIVATE KEY-----\n"
FIREBASE_CLIENT_EMAIL=firebase-adminsdk-xxxxx@your-project.iam.gserviceaccount.com
FIREBASE_CLIENT_ID=your-client-id
FIREBASE_AUTH_URI=https://accounts.google.com/o/oauth2/auth
FIREBASE_TOKEN_URI=https://oauth2.googleapis.com/token
FIREBASE_AUTH_PROVIDER_CERT_URL=https://www.googleapis.com/oauth2/v1/certs
FIREBASE_CLIENT_CERT_URL=https://www.googleapis.com/robot/v1/metadata/x509/firebase-adminsdk-xxxxx%40your-project.iam.gserviceaccount.com

# OpenAI Configuration (Optional)
OPENAI_API_KEY=your-openai-api-key
```

#### Firebase Setup
1. Create a Firebase project at https://console.firebase.google.com/
2. Enable Realtime Database
3. Go to Project Settings > Service Accounts
4. Generate a new private key (JSON format)
5. Copy the values from the JSON file to your `.env` file

#### Database Rules
Set your Firebase Realtime Database rules:
```json
{
  "rules": {
    ".read": true,
    ".write": true
  }
}
```

### 3. Frontend Setup

The frontend is ready to use - no additional setup required. All dependencies are loaded via CDN.

### 4. Start the Application

#### Backend Server
```bash
cd backend
python run.py
```
The API server will start on `http://localhost:5000`

#### Frontend
Open `frontend/index.html` in your web browser, or serve it with a local server:
```bash
cd frontend
python -m http.server 8000
```
Then visit `http://localhost:8000`

## 🔌 API Endpoints

### Patients
- `GET /api/patients` - Get all patients
- `POST /api/patients` - Create new patient
- `GET /api/patients/<id>` - Get patient details
- `PUT /api/patients/<id>` - Update patient
- `DELETE /api/patients/<id>` - Delete patient

### Devices
- `GET /api/devices` - Get all devices
- `POST /api/devices` - Register new device
- `GET /api/devices/<id>` - Get device details
- `PUT /api/devices/<id>` - Update device
- `DELETE /api/devices/<id>` - Delete device

### Vital Signs
- `GET /api/vitals` - Get all vital signs
- `POST /api/vitals` - Add vital signs reading
- `GET /api/vitals/<patient_id>` - Get patient's vital signs
- `GET /api/vitals/trends/<patient_id>` - Get vital signs trends

### Alerts
- `GET /api/alerts` - Get all alerts
- `POST /api/alerts` - Create alert
- `PUT /api/alerts/<id>/resolve` - Resolve alert
- `DELETE /api/alerts/<id>` - Delete alert

### AI Chatbot
- `POST /api/chatbot/chat` - Send message to AI assistant
- `GET /api/chatbot/history/<session_id>` - Get chat history

### Analytics
- `GET /api/analytics/dashboard` - Get dashboard statistics
- `GET /api/analytics/health-scores` - Get health score trends
- `GET /api/analytics/alerts-summary` - Get alerts summary

## 🎯 Usage

### Adding a Patient
1. Navigate to the "Patients" section
2. Click "Add Patient"
3. Fill in patient information
4. Click "Add Patient"

### Registering a Device
1. Go to the "Devices" section
2. Click "Add Device"
3. Enter device details
4. Optionally assign to a patient
5. Click "Add Device"

### Monitoring Vital Signs
- Devices automatically send data to the API
- View real-time data on the dashboard
- Check trends and receive alerts for abnormal readings

### Using AI Assistant
1. Visit the "AI Assistant" section
2. Type your health-related question
3. Or use quick action buttons for common queries
4. Get personalized health advice

## 🔧 Development

### Project Structure
```
iot-healthcare-system/
├── backend/
│   ├── app/
│   │   ├── __init__.py          # Flask app factory
│   │   ├── services/
│   │   │   ├── firebase_service.py    # Firebase operations
│   │   │   └── chatbot_service.py     # AI chatbot logic
│   │   ├── routes/
│   │   │   ├── api.py           # Main API routes
│   │   │   ├── health.py        # Health monitoring routes
│   │   │   └── chatbot.py       # AI chatbot routes
│   │   └── models/
│   │       └── __init__.py      # Data models
│   ├── utils/
│   │   └── helpers.py           # Utility functions
│   ├── run.py                   # Application entry point
│   ├── requirements.txt         # Python dependencies
│   └── .env.example             # Environment template
├── frontend/
│   ├── index.html               # Main HTML file
│   ├── css/
│   │   └── styles.css           # Application styles
│   └── js/
│       ├── main.js              # Application initialization
│       ├── api.js               # API service client
│       ├── ui.js                # UI management
│       ├── charts.js            # Chart.js integration
│       └── chatbot.js           # AI chatbot interface
└── README.md                    # This file
```

### Adding New Features

#### Backend
1. Create new service in `backend/app/services/`
2. Add routes in `backend/app/routes/`
3. Register blueprint in `backend/app/__init__.py`

#### Frontend
1. Add functionality to appropriate JS module
2. Update HTML structure if needed
3. Add styles to `css/styles.css`

## 🚨 Alert System

The system automatically generates alerts for:
- **Critical**: Heart rate < 50 or > 150 bpm
- **Critical**: Blood pressure > 180/120 or < 90/60
- **Critical**: Temperature > 103°F or < 95°F
- **Critical**: Oxygen saturation < 90%
- **Warning**: Abnormal trends or missing readings

## 🤖 AI Features

### Health Assistant Capabilities
- Symptom analysis and advice
- Medication information
- Emergency guidance
- Lifestyle recommendations
- Vital signs interpretation
- Health trend analysis

### Emergency Detection
The AI assistant can detect emergency situations and provide immediate guidance while suggesting professional medical help.

## 🔒 Security

- Environment variables for sensitive data
- Input validation and sanitization
- CORS protection
- Firebase authentication (when implemented)
- Secure API endpoints

## 📊 Monitoring & Analytics

- Real-time dashboard with key metrics
- Health score calculations
- Trend analysis with Chart.js visualizations
- Alert management and resolution tracking
- Device connectivity monitoring

## 🐛 Troubleshooting

### Common Issues

#### Backend Won't Start
- Check Python version (3.8+ required)
- Verify all dependencies are installed
- Check `.env` file configuration
- Ensure Firebase credentials are correct

#### Frontend Not Loading
- Check browser console for errors
- Verify all JavaScript files are loaded
- Check network connectivity to CDNs

#### Firebase Connection Issues
- Verify Firebase project configuration
- Check Realtime Database rules
- Ensure service account key is valid
- Check network connectivity

#### AI Chatbot Not Working
- Verify OpenAI API key
- Check API rate limits
- Ensure proper error handling

### Logs
- Backend logs are displayed in terminal
- Frontend errors appear in browser console
- Firebase errors are logged to console

## 📝 API Documentation

Detailed API documentation is available at `/api/docs` when the server is running (if Swagger is implemented).

## 🤝 Contributing

1. Fork the repository
2. Create a feature branch
3. Make your changes
4. Add tests if applicable
5. Submit a pull request

## 📄 License

This project is licensed under the MIT License - see the LICENSE file for details.

## 🆘 Support

For support and questions:
- Check the troubleshooting section
- Review the API documentation
- Open an issue on GitHub

## 🔄 Updates

Keep the system updated by:
- Regularly updating Python dependencies
- Monitoring Firebase service status
- Updating OpenAI API integration as needed
- Reviewing and updating security practices

---

**Note**: This system is designed for healthcare monitoring and should be used in conjunction with professional medical advice. Always consult healthcare professionals for medical decisions.
