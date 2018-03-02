from rest_framework import serializers
from scoring.models import ViewScene,ProtChoice,CmpdChoice,MolChoice,ScoreChoice

class ViewSceneSerializer(serializers.ModelSerializer):
    class Meta:
        model = ViewScene
        fields = ('id', 'uuid','title','scene',)

class ProtChoiceSerializer(serializers.ModelSerializer):
    class Meta:
        model = ProtChoice
        fields = ('id', 'user_id','prot_id','choice_type','score')

class MolChoiceSerializer(serializers.ModelSerializer):
    class Meta:
        model = MolChoice
        fields = ('id', 'user_id','mol_id','choice_type','score')

class CmpdChoiceSerializer(serializers.ModelSerializer):
    class Meta:
        model = CmpdChoice
        fields = ('id', 'user_id','cmpd_id','choice_type','score')

class ScoreChoiceSerializer(serializers.ModelSerializer):
    class Meta:
        model = ScoreChoice
        fields = ('id', 'user_id','mol_id','prot_id','choice_type','score','is_done')