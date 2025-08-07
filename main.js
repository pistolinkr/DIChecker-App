const { app, BrowserWindow, Menu, shell, dialog } = require('electron');
const path = require('path');
const fs = require('fs');

// Keep a global reference of the window object
let mainWindow;

function createWindow() {
  // Create the browser window
  mainWindow = new BrowserWindow({
    width: 1200,
    height: 800,
    minWidth: 800,
    minHeight: 600,
    webPreferences: {
      nodeIntegration: false,
      contextIsolation: true,
      enableRemoteModule: false,
      webSecurity: true
    },
    icon: path.join(__dirname, 'icon.png'),
    titleBarStyle: 'hiddenInset',
    show: false
  });

  // Load the app
  const startUrl = path.join(__dirname, 'index.html');
  mainWindow.loadFile(startUrl);

  // Show window when ready
  mainWindow.once('ready-to-show', () => {
    mainWindow.show();
  });

  // Handle window closed
  mainWindow.on('closed', () => {
    mainWindow = null;
  });

  // Handle external links
  mainWindow.webContents.setWindowOpenHandler(({ url }) => {
    shell.openExternal(url);
    return { action: 'deny' };
  });
}

// Create menu
function createMenu() {
  const template = [
    {
      label: 'Drug Interaction Checker',
      submenu: [
        {
          label: 'About Drug Interaction Checker',
          role: 'about'
        },
        { type: 'separator' },
        {
          label: 'Services',
          role: 'services',
          submenu: []
        },
        { type: 'separator' },
        {
          label: 'Hide Drug Interaction Checker',
          accelerator: 'Cmd+H',
          role: 'hide'
        },
        {
          label: 'Hide Others',
          accelerator: 'Cmd+Alt+H',
          role: 'hideothers'
        },
        {
          label: 'Show All',
          role: 'unhide'
        },
        { type: 'separator' },
        {
          label: 'Quit',
          accelerator: 'Cmd+Q',
          click: () => {
            app.quit();
          }
        }
      ]
    },
    {
      label: 'File',
      submenu: [
        {
          label: 'New Search',
          accelerator: 'Cmd+N',
          click: () => {
            if (mainWindow) {
              mainWindow.webContents.send('new-search');
            }
          }
        },
        {
          label: 'Clear History',
          click: () => {
            if (mainWindow) {
              mainWindow.webContents.send('clear-history');
            }
          }
        },
        { type: 'separator' },
        {
          label: 'Close',
          accelerator: 'Cmd+W',
          role: 'close'
        }
      ]
    },
    {
      label: 'Edit',
      submenu: [
        {
          label: 'Undo',
          accelerator: 'Cmd+Z',
          role: 'undo'
        },
        {
          label: 'Redo',
          accelerator: 'Shift+Cmd+Z',
          role: 'redo'
        },
        { type: 'separator' },
        {
          label: 'Cut',
          accelerator: 'Cmd+X',
          role: 'cut'
        },
        {
          label: 'Copy',
          accelerator: 'Cmd+C',
          role: 'copy'
        },
        {
          label: 'Paste',
          accelerator: 'Cmd+V',
          role: 'paste'
        },
        {
          label: 'Select All',
          accelerator: 'Cmd+A',
          role: 'selectall'
        }
      ]
    },
    {
      label: 'View',
      submenu: [
        {
          label: 'Reload',
          accelerator: 'Cmd+R',
          click: () => {
            if (mainWindow) {
              mainWindow.reload();
            }
          }
        },
        {
          label: 'Force Reload',
          accelerator: 'Cmd+Shift+R',
          click: () => {
            if (mainWindow) {
              mainWindow.webContents.reloadIgnoringCache();
            }
          }
        },
        {
          label: 'Toggle Developer Tools',
          accelerator: 'F12',
          click: () => {
            if (mainWindow) {
              mainWindow.webContents.toggleDevTools();
            }
          }
        },
        { type: 'separator' },
        {
          label: 'Actual Size',
          accelerator: 'Cmd+0',
          click: () => {
            if (mainWindow) {
              mainWindow.webContents.setZoomLevel(0);
            }
          }
        },
        {
          label: 'Zoom In',
          accelerator: 'Cmd+Plus',
          click: () => {
            if (mainWindow) {
              mainWindow.webContents.setZoomLevel(mainWindow.webContents.getZoomLevel() + 1);
            }
          }
        },
        {
          label: 'Zoom Out',
          accelerator: 'Cmd+-',
          click: () => {
            if (mainWindow) {
              mainWindow.webContents.setZoomLevel(mainWindow.webContents.getZoomLevel() - 1);
            }
          }
        },
        { type: 'separator' },
        {
          label: 'Toggle Full Screen',
          accelerator: 'Ctrl+Cmd+F',
          click: () => {
            if (mainWindow) {
              mainWindow.setFullScreen(!mainWindow.isFullScreen());
            }
          }
        }
      ]
    },
    {
      label: 'Window',
      submenu: [
        {
          label: 'Minimize',
          accelerator: 'Cmd+M',
          role: 'minimize'
        },
        {
          label: 'Zoom',
          role: 'zoom'
        },
        { type: 'separator' },
        {
          label: 'Bring All to Front',
          role: 'front'
        }
      ]
    },
    {
      label: 'Help',
      submenu: [
        {
          label: 'Learn More',
          click: () => {
            shell.openExternal('https://github.com/yourusername/drug-interaction-checker');
          }
        },
        {
          label: 'Documentation',
          click: () => {
            shell.openExternal('https://github.com/yourusername/drug-interaction-checker#readme');
          }
        },
        { type: 'separator' },
        {
          label: 'Report Issue',
          click: () => {
            shell.openExternal('https://github.com/yourusername/drug-interaction-checker/issues');
          }
        }
      ]
    }
  ];

  const menu = Menu.buildFromTemplate(template);
  Menu.setApplicationMenu(menu);
}

// App event handlers
app.whenReady().then(() => {
  createWindow();
  createMenu();

  app.on('activate', () => {
    if (BrowserWindow.getAllWindows().length === 0) {
      createWindow();
    }
  });
});

app.on('window-all-closed', () => {
  if (process.platform !== 'darwin') {
    app.quit();
  }
});

// Security: Prevent new window creation
app.on('web-contents-created', (event, contents) => {
  contents.on('new-window', (event, navigationUrl) => {
    event.preventDefault();
    shell.openExternal(navigationUrl);
  });
}); 