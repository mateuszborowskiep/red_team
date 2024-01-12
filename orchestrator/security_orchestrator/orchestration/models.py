from django.db import models

class Project(models.Model):
    name = models.CharField(max_length=255)
    repository_url = models.URLField(max_length=500)
    last_scanned = models.DateTimeField(null=True, blank=True)

    def __str__(self):
        return self.name

class ScanReport(models.Model):
    project = models.ForeignKey(Project, on_delete=models.CASCADE)
    scanned_at = models.DateTimeField(auto_now_add=True)
    commit_hash = models.CharField(max_length=40)

    def __str__(self):
        return f"{self.project.name} - {self.scanned_at.strftime('%Y-%m-%d %H:%M:%S')}"

class Vulnerability(models.Model):
    SEVERITY_CHOICES = [
        ('INFO', 'Information'),
        ('LOW', 'Low'),
        ('MEDIUM', 'Medium'),
        ('HIGH', 'High'),
        ('CRITICAL', 'Critical')
    ]

    report = models.ForeignKey(ScanReport, on_delete=models.CASCADE)
    file_path = models.CharField(max_length=500)
    line_number = models.IntegerField()
    rule_id = models.CharField(max_length=100)
    message = models.TextField()
    severity = models.CharField(max_length=8, choices=SEVERITY_CHOICES, default='LOW')

    def __str__(self):
        return f"{self.rule_id} in {self.file_path}:{self.line_number}"
