# Automotive Software Engineering Assignment #1 : Build DNN Object Detection Container  

## I. Github & Docker Hub Link

- Github Link : [ASE-Assignment-YOLO](https://github.com/아이디/레포지토리명)
- Docker Hub Link : [hyeokk64/yolo](https://hub.docker.com/repository/docker/hyeokk64/yolo/general)

## II. Insights

- Docker image / container 개념을 실습을 통해 정리함:contentReference[oaicite:0]{index=0}  
- venv / Anaconda 대비 Docker의 장점(OS까지 포함한 완전한 실행 환경 캡슐화)을 체감  
- 하나의 이미지로 여러 컨테이너를 생성하여 의존성 충돌 없이 실험 가능  
- Dockerfile 기반 이미지 생성이 `docker commit`보다 재현성·유지보수·협업·최적화 측면에서 유리함:contentReference[oaicite:1]{index=1}  
- 팀 구성원 간 개발 환경이 달라도 Docker로 동일 환경을 공유할 수 있음을 경험  

## III. Implementation Details

- Base OS: Ubuntu 20.04  
- 필수 패키지 설치: `build-essential`, `cmake`, `git`, `wget`, `libopencv-dev`, `pkg-config` 등  
- Darknet YOLOv3 설치
  - `git clone https://github.com/pjreddie/darknet`
  - `cd darknet && make`
- `detect.sh`
  - 인자로 이미지 URL을 입력받아 `input.jpg`로 다운로드
  - 다운로드 실패 시 에러 메시지 출력 후 종료
  - `/darknet` 디렉터리에서  
    `./darknet detector test cfg/coco.data cfg/yolov3.cfg yolov3.weights input.jpg -dont_show` 실행
- Dockerfile
  - 타임존 및 비대화형 설정(ENV `TZ`, `DEBIAN_FRONTEND`) 적용
  - YOLO 빌드를 위한 의존성 및 Darknet 설치
  - `detect.sh`를 `/usr/local/bin/detect`로 복사 후 실행 권한 부여
  - `ENTRYPOINT ["detect"]`로 설정하여 컨테이너 시작 시 자동으로 스크립트 실행:contentReference[oaicite:2]{index=2}  

## IV. How to Run

```bash
# Docker 이미지 다운로드
docker pull hyeokk64/yolo:latest

# 이미지 URL을 인자로 전달하여 YOLOv3 객체 검출 수행
docker run --rm hyeokk64/yolo <image_url>
