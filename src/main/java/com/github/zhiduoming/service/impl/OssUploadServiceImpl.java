package com.github.zhiduoming.service.impl;

import com.aliyun.oss.OSS;
import com.aliyun.oss.OSSClientBuilder;
import com.aliyun.oss.ClientException;
import com.aliyun.oss.OSSException;
import com.aliyun.oss.model.ObjectMetadata;
import com.github.zhiduoming.config.OssProperties;
import com.github.zhiduoming.service.OssUploadService;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import java.io.IOException;
import java.io.InputStream;
import java.util.Locale;
import java.util.Set;
import java.util.UUID;

@Service
public class OssUploadServiceImpl implements OssUploadService {

    private static final long MAX_AVATAR_SIZE = 5 * 1024 * 1024L;
    //设置允许上传的图片类型
    private static final Set<String> ALLOWED_CONTENT_TYPES = Set.of(
            "image/jpeg",
            "image/png",
            "image/webp",
            "image/gif"
    );

    private final OssProperties ossProperties;

    public OssUploadServiceImpl(OssProperties ossProperties) {
        this.ossProperties = ossProperties;
    }

    @Override
    public String uploadAvatar(Long userId, MultipartFile file) {
        validateOssConfig();
        validateAvatar(file);

        String objectKey = buildAvatarObjectKey(userId, file.getOriginalFilename());
        ObjectMetadata metadata = new ObjectMetadata();
        metadata.setContentLength(file.getSize());
        metadata.setContentType(file.getContentType());

        OSS ossClient = new OSSClientBuilder().build(
                ossProperties.getEndpoint(),
                ossProperties.getAccessKeyId(),
                ossProperties.getAccessKeySecret()
        );
        try (InputStream inputStream = file.getInputStream()) {
            ossClient.putObject(ossProperties.getBucketName(), objectKey, inputStream, metadata);
        } catch (OSSException e) {
            throw new RuntimeException("OSS 上传失败，请检查 Bucket 权限和 Endpoint 配置");
        } catch (ClientException e) {
            throw new RuntimeException("OSS 连接失败，请检查 AccessKey、网络和 Endpoint 配置");
        } catch (IOException e) {
            throw new RuntimeException("头像文件读取失败");
        } finally {
            ossClient.shutdown();
        }

        return buildPublicUrl(objectKey);
    }

    private void validateOssConfig() {
        if (isBlank(ossProperties.getEndpoint())
                || isBlank(ossProperties.getAccessKeyId())
                || isBlank(ossProperties.getAccessKeySecret())
                || isBlank(ossProperties.getBucketName())) {
            throw new RuntimeException("OSS 配置未完成，请检查环境变量");
        }
    }

    private void validateAvatar(MultipartFile file) {
        if (file == null || file.isEmpty()) {
            throw new RuntimeException("请选择头像文件");
        }
        if (file.getSize() > MAX_AVATAR_SIZE) {
            throw new RuntimeException("头像文件不能超过 2MB");
        }
        String contentType = file.getContentType();
        if (contentType == null || !ALLOWED_CONTENT_TYPES.contains(contentType.toLowerCase(Locale.ROOT))) {
            throw new RuntimeException("头像仅支持 JPG、PNG、WEBP 或 GIF");
        }
    }

    private String buildAvatarObjectKey(Long userId, String originalFilename) {
        String extension = resolveExtension(originalFilename);
        String dir = trimSlashes(ossProperties.getAvatarDir());
        return dir + "/" + userId + "/" + UUID.randomUUID() + extension;
    }

    private String resolveExtension(String originalFilename) {
        if (originalFilename == null) {
            return ".jpg";
        }
        String name = originalFilename.toLowerCase(Locale.ROOT);
        int dotIndex = name.lastIndexOf('.');
        if (dotIndex < 0 || dotIndex == name.length() - 1) {
            return ".jpg";
        }
        String extension = name.substring(dotIndex);
        return switch (extension) {
            case ".jpg", ".jpeg", ".png", ".webp", ".gif" -> extension;
            default -> ".jpg";
        };
    }

    private String buildPublicUrl(String objectKey) {
        String publicBaseUrl = ossProperties.getPublicBaseUrl();
        if (!isBlank(publicBaseUrl)) {
            return trimTrailingSlash(publicBaseUrl) + "/" + objectKey;
        }
        String endpoint = ossProperties.getEndpoint()
                .replaceFirst("^https?://", "");
        return "https://" + ossProperties.getBucketName() + "." + endpoint + "/" + objectKey;
    }

    private String trimSlashes(String value) {
        if (isBlank(value)) {
            return "avatars";
        }
        return value.replaceAll("^/+", "").replaceAll("/+$", "");
    }

    private String trimTrailingSlash(String value) {
        return value.replaceAll("/+$", "");
    }

    private boolean isBlank(String value) {
        return value == null || value.trim().isEmpty();
    }
}
