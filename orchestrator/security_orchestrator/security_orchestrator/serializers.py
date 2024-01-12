from rest_framework import serializers
from .models import Project, ScanReport, Vulnerability

class ProjectSerializer(serializers.ModelSerializer):
    class Meta:
        model = Project
        fields = ['id', 'name', 'repository_url', 'last_scanned']

class ScanReportSerializer(serializers.ModelSerializer):
    class Meta:
        model = ScanReport
        fields = ['id', 'project', 'scanned_at', 'commit_hash']

class VulnerabilitySerializer(serializers.ModelSerializer):
    class Meta:
        model = Vulnerability
        fields = ['id', 'report', 'file_path', 'line_number', 'rule_id', 'message', 'severity']