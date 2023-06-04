from PySide6.QtWidgets import QApplication, QMainWindow, QLabel
from PySide6.QtCore import Qt
import sys

def main(argv=["main.py"]):
    app = QApplication(argv)
    window = QMainWindow()
    window.show()

    label = QLabel('My Awesome App')
    label.setAlignment(Qt.AlignCenter)
    window.setCentralWidget(label)

    return app.exec()

if __name__ == '__main__':
    exit_code = main()
    sys.exit(exit_code)
