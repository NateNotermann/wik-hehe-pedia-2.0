import React from 'react';
import ReactDOM from 'react-dom';
import { Provider } from 'react-redux';

import store from './redux/store';

import App from './components/App/App';

// MUI Theme imports // 
import { createTheme, ThemeProvider, styled } from '@mui/material/styles';
import { red, blue, green, purple, yellow, orange } from '@mui/material/colors';

const theme = createTheme({
// --  typography --> specific to React Element '<typography>' -- //
  typography: {
    label1: {
      fontSize: 23,
      light: '#33b7ff',
      main: '#005B94', // was #00a6ff. Changed to pass contrast ratio standards 
      dark: '#0074b2',
    }  
  },

  // -- pallette --> is the default global color scheme. -- // 
  palette: {
    primary: {
      light: '#33b7ff',
      main: '#33b7ff', // was #00a6ff. Changed to pass contrast ratio standards 
      dark: '#0074b2',
    },
    secondary: {  
      light: '#eb6ba8',
      main: '#FF6896',
      dark: '#a13166',
    },
    third: {  
      light: '#ffffff',
      main: '#fafafa',
      dark: '#c7c7c7',
    },
    forth: {  
      light: '#6effe8',
      main: '#1de9b6',
      dark: '#00b686',
    },
    fifthBlack: {  
      light: '#484848',
      main: '#212121',
      dark: '#000000',
    },
    input: {  
      light: '#e91e63',
      main: '#000000',
      dark: '#b0003a',
    },
    youtube: {
      light: '#ff6434',
      main: '#dd2c00',
      dark: '#a30000',
    },
    success: {
      main: green[500]
    },
    warning: {
      main: red[500]
    },
    error: {
      main: red[500]
    },
    text: {
      primary: '#00a6ff', // ---- This is PRIMARY TEXT COLOR attribute. ----was #00a6ff. Changed to '#005B94' and then changed BACK. PWA wants more contrast than '#00a6ff'. 
      secondary: '#e64693', // Dark blue --> '#0074b2'.  Hot Pink --> '#e64693'
      // primary: '#fafafa',
      // secondary: '#212121',
    }
  },
  zIndex: {
    background: 1000,
    comedianBackground: 1200,
    comedianItem: 1250,
    comedianDetails: 1300,
    snackbar: 1400,
    tooltip: 1500,
  }
  // shape: {
  //   borderRadius: 3
  // }
});



ReactDOM.render(
  <Provider store={store}>
    <ThemeProvider theme={theme}>
    <App />
    </ThemeProvider>
  </Provider>,
  document.getElementById('react-root'),
);
