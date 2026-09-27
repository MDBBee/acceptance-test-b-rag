import os
from pathlib import Path
from dotenv import load_dotenv

_env_path = Path(__file__).parent / ".env"
load_dotenv(_env_path)

BASE_URL = str(os.environ["BASE_URL"])
TEST_EMAIL = str(os.environ["TEST_EMAIL"])
TEST_CODE = str(os.environ["TEST_CODE"])
TEST_PDF_PATH = str(os.environ["TEST_PDF_PATH"])
TESTER_NAME = str(os.environ["TESTER_NAME"])
